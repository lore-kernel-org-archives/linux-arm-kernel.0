From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 09 Dec 2011 14:50:27 +0400
Subject: [PATCH v4 5/5] ARM: davinci: create new common platform header
 for davinci
In-Reply-To: <1323352528-1207-6-git-send-email-manjunath.hadli@ti.com>
References: <1323352528-1207-1-git-send-email-manjunath.hadli@ti.com>
 <1323352528-1207-6-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EE1E7F3.3050509@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-12-2011 17:55, Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file davinci.h.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
[...]

> diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
> new file mode 100644
> index 0000000..1fafbd7
> --- /dev/null
> +++ b/arch/arm/mach-davinci/davinci.h
> @@ -0,0 +1,88 @@
[...]
> +/* DM646x function declarations */
> +void __init dm646x_init(void);
> +void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
> +void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
> +void __init dm646x_board_setup_refclk(struct clk *clk);

    I don't see from where are you moving this prototype -- it wasn't in the 
original #include file... In fact, I'm not even seeing this function in the 
current Linus tree...

> +int __init dm646x_init_edma(struct edma_rsv_info *rsv);
> +
> +void dm646x_video_init(void);
> +
> +void dm646x_setup_vpif(struct vpif_display_config *,
> +		       struct vpif_capture_config *);
> +#endif /*__DAVINCI_H */
[...]
> diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
> deleted file mode 100644
> index eb95864..0000000
> --- a/arch/arm/mach-davinci/include/mach/dm646x.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * Chip specific defines for DM646x SoC
> - *
> - * Author: Kevin Hilman, Deep Root Systems, LLC
> - *
> - * 2007 (c) Deep Root Systems, LLC. This file is licensed under
> - * the terms of the GNU General Public License version 2. This program
> - * is licensed "as is" without any warranty of any kind, whether express
> - * or implied.
> - */
> -#ifndef __ASM_ARCH_DM646X_H
> -#define __ASM_ARCH_DM646X_H
> -
> -#include<mach/hardware.h>
> -#include<mach/asp.h>
> -#include<linux/i2c.h>
> -#include<linux/videodev2.h>
> -#include<linux/davinci_emac.h>
> -#include<media/davinci/vpif_types.h>
> -
> -#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
> -#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
> -
> -void __init dm646x_init(void);
> -void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
> -void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
> -int __init dm646x_init_edma(struct edma_rsv_info *rsv);
> -
> -void dm646x_video_init(void);
> -
> -void dm646x_setup_vpif(struct vpif_display_config *,
> -		       struct vpif_capture_config *);
> -
> -#endif /* __ASM_ARCH_DM646X_H */

WBR, Sergei
