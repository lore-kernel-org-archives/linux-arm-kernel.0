From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 04 May 2012 21:45:20 +0200
Subject: [PATCH-V6 1/3] ARM: OMAP1: FIX: check possible error condition in
 timer_init
In-Reply-To: <20120504174301.GH5613@atomide.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
 <87y5pafis6.fsf@ti.com> <20120504174301.GH5613@atomide.com>
Message-ID: <1353295.rIGgu9aSFg@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia pi?tek, 4 maja 2012 10:43:02 Tony Lindgren pisze:
> Hi,
> 
> * Kevin Hilman <khilman@ti.com> [120502 13:11]:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> > 
> > > OMAP1, omap_32k_timer_init() function always returns "true",
> > > irrespective of whether error occurred while initializing 32k sync
> > > counter as a kernel clocksource or not and execution will never
> > > fallback to mpu_timer clocksource init code.
> > >
> > > This patch adds check for return value from function
> > > omap_init_clocksource_32k(), and fallback to omap_mpu_timer_init()
> > > in case of failure/error from omap_init_clocksource_32k().
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Kevin Hilman <khilman@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > ---
> > > This is new patch addition compared to original series (<=V5).
> > >
> > > Also, note that, this patch is only compile tested, since
> > > I do not have omap1 board with me to validate it.
> > > Kevin, can you help me to validate it.
> > 
> > I boot tested on OMAP1 (5912/OSK) with 32k timer and MPU timer
> > Kconfigs.  Works fine, but needs small change below for compile 
warnings.
> > 
> > Otherwise, looks good.
> 
> We need at least one tested-by on some 15xx platform for these 
changes.
> Janusz, can you please give this series a try on your board too?

Sure, but in a week or so.

I'm still trying to follow the l-o list, but please always Cc: me for 
testing any changes on Amstrad Delta whenever you see fit.

Regards,
Janusz
