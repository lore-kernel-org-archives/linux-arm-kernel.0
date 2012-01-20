From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 20 Jan 2012 10:31:49 +0100
Subject: [PATCH] ep93xx: Convert the watchdog driver into a platform
 device.
In-Reply-To: <201201191701.30836.hartleys@visionengravers.com>
References: <201201191701.30836.hartleys@visionengravers.com>
Message-ID: <20120120093149.GX27296@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

...
>  void ep93xx_restart(char mode, const char *cmd)
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index c4a7b84..e9271a7 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -224,6 +224,7 @@
>  #define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
>  
> +#define EP93XX_WATCHDOG_PHYS_BASE	EP93XX_APB_PHYS(0x00140000)
>  #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)

Shouldn't this last define be removed after you added the new PHYS_BASE ?

Kind regards,
Wim.
