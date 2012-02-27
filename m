From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 17:39:39 +0800
Subject: [PATCH] ARM: mach-imx: mx3: Fix section mismatch in
 imx3_init_l2x0()
In-Reply-To: <1330273624-5757-1-git-send-email-festevam@gmail.com>
References: <1330273624-5757-1-git-send-email-festevam@gmail.com>
Message-ID: <20120227093937.GC31207@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 01:27:04PM -0300, Fabio Estevam wrote:
> Fix the following section mismatch:
> 
> WARNING: vmlinux.o(.text+0x11be8): Section mismatch in reference from the function imx3_init_l2x0() to the function .init.text:l2x0_init()
> The function imx3_init_l2x0() references
> the function __init l2x0_init().
> This is often because imx3_init_l2x0 lacks a __init 
> annotation or the annotation of l2x0_init is wrong.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I'm seeing this warning with imx_v6_v7_defconfig build too, and would
like to send a fix for -rc right away.

Regards,
Shawn

> ---
>  arch/arm/mach-imx/mm-imx3.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 8404ee7..6222151 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -76,7 +76,7 @@ static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
>  	return __arm_ioremap(phys_addr, size, mtype);
>  }
>  
> -void imx3_init_l2x0(void)
> +void __init imx3_init_l2x0(void)
>  {
>  	void __iomem *l2x0_base;
>  	void __iomem *clkctl_base;
> -- 
> 1.7.1
