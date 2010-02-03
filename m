From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 10:18:02 +0000
Subject: [PATCH 10/16] ARM: LPC32XX: Converted most register types to
	void __iomem *
In-Reply-To: <1265155168-28909-11-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-11-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203101802.GD22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 03:59:22PM -0800, wellsk40 at gmail.com wrote:
> diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
> index adc932b..93541f4 100644
> --- a/arch/arm/mach-lpc32xx/include/mach/platform.h
> +++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
> @@ -23,6 +23,8 @@
>  #ifndef __ASM_ARCH_PLATFORM_H
>  #define __ASM_ARCH_PLATFORM_H
>  
> +#define IOMEM(x, y)			(__force void __iomem *)((x) + (y))

Hmm, I'd prefer if this wasn't soo different from the definitions found
in other platforms - so maybe one day we can move this to the arch level.

The best definition for it is:

#define IOMEM(x) ((void __iomem *)(unsigned long)(x))

which I believe avoids sparse complaints without having to resort to
__force.
