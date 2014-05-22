From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 May 2014 16:28:55 -0700
Subject: [PATCH 0/5] ARM: omap3-lilly-a83x: update board support
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <20140522232854.GD29577@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> This set of patches updates board support for omap3-lilly-a83x.
> 
> Christoph Fritz (5):
>   [RFC-HACK] pinctrl-single: init by postcore_initcall()

I would prefer to start initializing other things later as
then we get proper error messages on the console. Let's first
investigate a bit more if we can just initialize other
drivers later on.

Which version of kernel are you using? With all the fixes
that have gone into this -rc cycle, v3.15-rc4 is pretty much
the first kernel that should behave for us properly for
deferred probe for irqchips that get initialized later on.

Regards,

Tony 

>   [RFC-HACK] ARM: dts: OMAP3: reorder pinmux_gpio1_pins
>   ARM: dts: omap3: set mcbsp2 status
>   [RFC] ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable
>   ARM: dts: OMAP3 a83x: fix duplicate usb pin config
> 
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    7 +++---
>  arch/arm/boot/dts/omap34xx.dtsi         |   28 ++++++++++++----------
>  arch/arm/boot/dts/omap36xx.dtsi         |   40 ++++++++++++++++---------------
>  arch/arm/mach-omap2/gpmc-nand.c         |   16 +++++--------
>  drivers/pinctrl/pinctrl-single.c        |   15 ++++++++++++
>  5 files changed, 61 insertions(+), 45 deletions(-)
> 
> -- 
> 1.7.10.4
> 
