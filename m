From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 17 Aug 2012 23:43:44 +0530
Subject: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp header into
 platform and audio specific
In-Reply-To: <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <502E89D8.2090304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gururaja,

On 8/14/2012 6:12 PM, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.
> 
> Audio specific defines is moved to to common
> <linux/platform_data/davinci_asp.h> so that the header can be
> accessed by all related platforms.
> 
> While here, correct the header usage (remove multiple header
> re-definitions and unused headers) and remove platform names from
> structures comments and enum
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

This patch looks good to me. See a minor nit below.

Acked-by: Sekhar Nori <nsekhar@ti.com>

> diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
> new file mode 100644
> index 0000000..8fd5238
> --- /dev/null
> +++ b/arch/arm/mach-davinci/asp.h
> @@ -0,0 +1,49 @@
> +/*
> + * TI DaVinci Audio definitions
> + */
> +#ifndef __ASM_ARCH_DAVINCI_ASP_H
> +#define __ASM_ARCH_DAVINCI_ASP_H
> +
> +/* Bases of dm644x and dm355 register banks */
> +#define DAVINCI_ASP0_BASE	0x01E02000
> +#define DAVINCI_ASP1_BASE	0x01E04000
> +
> +/* Bases of dm365 register banks */
> +#define DAVINCI_DM365_ASP0_BASE	0x01D02000
> +
> +/* Bases of dm646x register banks */
> +#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
> +#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800

Can you remove usage of tabs after 'define'. I understand this is coming
from existing code.

Thanks,
Sekhar
