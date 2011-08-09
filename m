From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter?= Ujfalusi)
Date: Tue, 9 Aug 2011 14:17:07 +0300
Subject: OMAP3 kernels fail to build
In-Reply-To: <20110808110056.GA15134@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Message-ID: <39807124.qlKmXN27Pu@barack>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Monday 08 August 2011 13:00:56 Russell King - ARM Linux wrote:
> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> 
> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to
> `omap4430_phy_init' arch/arm/mach-omap2/built-in.o:(.data+0xf9a0):
> undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to
> `omap4430_phy_power' arch/arm/mach-omap2/built-in.o:(.data+0xf9a8):
> undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to
> `omap4430_phy_suspend'
>
> This is probably from twl-common.c, which doesn't really look very
> common to me (looks like some is specific to OMAP3 and the rest is
> OMAP4 specific.)
> 
> As this is always built for all OMAP2+, this will also break OMAP2 as
> well.  Why it's even built on OMAP2, I've no idea.

I'm sure if you have it other way around (OMAP4=y, OMAP3=n) will fail as well, 
but differently...

> I think the OMAP3 specific bits should be separate from the OMAP4
> specific bits, which should be separate from the small amount of
> common stuff.

Is it acceptable if I use
#if defined(CONFIG_ARCH_OMAP3), and
#if defined(CONFIG_ARCH_OMAP4)

to protect the OMAP3 and OMAP4 related code in the twl-common.c?

-- 
P?ter
