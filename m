From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 20:19:09 +0100
Subject: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
In-Reply-To: <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150507191909.GC16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > index 388c88a..0b1a784 100644
> > --- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> > @@ -1,20 +1,23 @@
> >  STMicroelectronics Low Power Controller (LPC) - Watchdog
> >  ========================================================
> >  
> > -LPC currently supports Watchdog OR Real Time Clock functionality.
> > +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> > +functionality.
> >  
> >  [See: ../rtc/rtc-st-lpc.txt for RTC options]
> > +[See: ../timer/st,stih407-lpc for Clocksource options]
> >  
> >  Required properties
> >  
> > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > -				  "st,stih415-lpc" "st,stid127-lpc"
> > +- compatible 	: Must be one of: "st,stih407-lpc"
> 
> The same comment as the RTC DT patch, you are removing the compatibles
> documentation for the other supported platforms like stih416-lpc.
> AFAIK they are required in the driver to get the correct sysconfig register.

That's intentional.  I haven't yet tested any of this IP on
STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
sure if this IP even exists on some of the other platforms.  I will
add them back when support is added to both driver and DTB and I've
been able to test them.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
