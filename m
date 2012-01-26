From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 19:10:14 +0800
Subject: [PATCH] ARM: mxc: add missing include
In-Reply-To: <20120126104306.GE20173@pengutronix.de>
References: <20120126104306.GE20173@pengutronix.de>
Message-ID: <20120126111011.GA3523@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 11:43:06AM +0100, Robert Schwebel wrote:
> Without this include, we get the following error when building
> imx_v4_v5_defconfig:
> 
> In file included from arch/arm/plat-mxc/include/mach/iomux-mx27.h:23:0,
>                  from arch/arm/mach-imx/mach-imx27ipcam.c:22:
> arch/arm/plat-mxc/include/mach/iomux-v1.h:99:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'imx_iomuxv1_init'
> 

Fabio had posted a patch below to fix the same issue, which is still
pending on Sascha to apply.

http://www.spinics.net/lists/arm-kernel/msg154514.html

IMO, Fabio's the fixing is better than this patch, since we do not
necessarily need '__init' annotation for function prototype declaration.

Regards,
Shawn

> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-v1.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
> index 6fa8a70..d9a7787 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
> @@ -19,6 +19,8 @@
>  #ifndef __MACH_IOMUX_V1_H__
>  #define __MACH_IOMUX_V1_H__
>  
> +#include <linux/init.h>
> +
>  /*
>  *  GPIO Module and I/O Multiplexer
>  *  x = 0..3 for reg_A, reg_B, reg_C, reg_D
> -- 
> 1.7.8.3
