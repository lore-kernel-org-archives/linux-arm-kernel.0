From: richard.zhao@freescale.com (Richard Zhao)
Date: Sat, 31 Dec 2011 11:31:08 +0800
Subject: [PATCH] ARM: imx6: remove __CPUINIT annotation from
 v7_invalidate_l1
In-Reply-To: <1325296251-11144-1-git-send-email-shawn.guo@linaro.org>
References: <1325296251-11144-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111231033107.GG2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 09:50:51AM +0800, Shawn Guo wrote:
> The recent suspend testing on !SMP build discovers that the __CPUINIT
> annotation for v7_invalidate_l1 should not be there, as the function
> is called by resume path for not only SMP but also !SMP build.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/head-v7.S |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> index c844112..914f2a1 100644
> --- a/arch/arm/mach-imx/head-v7.S
> +++ b/arch/arm/mach-imx/head-v7.S
> @@ -16,7 +16,6 @@
>  #include <asm/hardware/cache-l2x0.h>
>  
>  	.section ".text.head", "ax"
why do we put it this specific section, rather not .text?

Thanks
Richard
> -	__CPUINIT
>  
>  /*
>   * The secondary kernel init calls v7_flush_dcache_all before it enables
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
