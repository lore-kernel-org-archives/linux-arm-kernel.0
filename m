From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Oct 2014 15:12:06 -0700
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141031211325.GC31454@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141031193057.GC12379@n2100.arm.linux.org.uk>
 <20141031211325.GC31454@atomide.com>
Message-ID: <20141031221205.GD31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141031 14:16]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 12:32]:
> > 
> > Last night I tried enabling DT booting on the LDP.  This resulted in
> > quite a horrid mess, so I don't think you're there still.
> 
> Thanks for trying. Other than the mystery battery issue, the others
> should pretty much go away with just .config changes it seems.

To dt-fy your .config, looks like you need to add these to your build
system seed config file:

CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_CMA=y
CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=y
CONFIG_DMA_CMA=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PINCTRL_SINGLE=y

That should actually improve your setup from the current booting
with the framebuffer enabled ;)

I also posted the defconfig and demsg for you to diff against to:

http://muru.com/for-rmk/

I wonder if the battery charger hardware is broken on your LDP?

I don't think that is even being enabled in the legacy boot for
LDP as it as there's no struct twl4030_bci being passed except
from board-omap3pandora.c.

Regards,

Tony
