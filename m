From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 26 Sep 2011 11:06:23 +0200
Subject: [PATCH 1/2] ARM: pxa: fix building error by palm27x_lcd_init()
	when FB_PXA not defined
In-Reply-To: <CAMPhdO-gZOnMjHog0t7cp74rs+Z+D76v2dPLBgp+jUGNG9J39A@mail.gmail.com>
References: <1317009197-12578-1-git-send-email-eric.y.miao@gmail.com>
	<201109261100.07265.marek.vasut@gmail.com>
	<CAMPhdO-gZOnMjHog0t7cp74rs+Z+D76v2dPLBgp+jUGNG9J39A@mail.gmail.com>
Message-ID: <201109261106.24026.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 26, 2011 11:02:03 AM Eric Miao wrote:
> 2011/9/26 Marek Vasut <marek.vasut@gmail.com>:
> > On Monday, September 26, 2011 05:53:16 AM Eric Miao wrote:
> >> Cc: Marek Vasut <marek.vasut@gmail.com>
> >> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >> ---
> >>  arch/arm/mach-pxa/include/mach/palm27x.h |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h
> >> b/arch/arm/mach-pxa/include/mach/palm27x.h index 0a5e5ea..f80bbe2 100644
> >> --- a/arch/arm/mach-pxa/include/mach/palm27x.h
> >> +++ b/arch/arm/mach-pxa/include/mach/palm27x.h
> >> @@ -34,7 +34,7 @@ extern struct pxafb_mode_info
> >> palm_320x320_new_lcd_mode; extern void __init palm27x_lcd_init(int
> >> power,
> >>                                       struct pxafb_mode_info *mode);
> >>  #else
> >> -static inline void palm27x_lcd_init(int power, struct pxafb_mode_info
> >> *mode) {} +#define palm27x_lcd_init(power, mode)      do {} while (0)
> >>  #endif
> >> 
> >>  #if  defined(CONFIG_USB_GADGET_PXA27X) || \
> > 
> > Hi Eric,
> > 
> > NAK. Why do you do such a change ? Especially as this will likely
> > interfere with gcc4.6's unused-but-set variable checking.
> 
> OK, I'll hold this one. Feel free to give me a solution.

Hang on, I'll run it through the cogs.
