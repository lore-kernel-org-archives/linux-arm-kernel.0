From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 Jan 2015 09:55:20 +0000
Subject: [PATCH] mfd: db8500-prcmu:  Remove unused function
In-Reply-To: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20150119095520.GN21886@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 01 Jan 2015, Rickard Strandqvist wrote:

> Remove the function prcmu_get_boot_status() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/mfd/db8500-prcmu.c |    9 ---------
>  1 file changed, 9 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 193cf16..b517501 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -675,15 +675,6 @@ bool prcmu_has_arm_maxopp(void)
>  }
>  
>  /**
> - * prcmu_get_boot_status - PRCMU boot status checking
> - * Returns: the current PRCMU boot status
> - */
> -int prcmu_get_boot_status(void)
> -{
> -	return readb(tcdm_base + PRCM_BOOT_STATUS);
> -}
> -
> -/**
>   * prcmu_set_rc_a2p - This function is used to run few power state sequences
>   * @val: Value to be set, i.e. transition requested
>   * Returns: 0 on success, -EINVAL on invalid argument

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
