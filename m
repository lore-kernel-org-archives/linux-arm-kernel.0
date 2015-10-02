From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Oct 2015 09:03:32 +0900
Subject: [PATCH] thermal: exynos: fix register read in TMU
In-Reply-To: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <560DC9D4.2000301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 10? 01? 20:39, Sudip Mukherjee wrote:
> The value of emul_con was getting overwritten if the selected soc is
> SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
> register in the case of SOC_ARCH_EXYNOS5260.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 0bae8cc..ca920b0 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -932,7 +932,7 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
>  
>  	if (data->soc == SOC_ARCH_EXYNOS5260)
>  		emul_con = EXYNOS5260_EMUL_CON;
> -	if (data->soc == SOC_ARCH_EXYNOS5433)
> +	else if (data->soc == SOC_ARCH_EXYNOS5433)
>  		emul_con = EXYNOS5433_TMU_EMUL_CON;
>  	else if (data->soc == SOC_ARCH_EXYNOS7)
>  		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
> 

Thanks for your point out. Looks good to me. 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
