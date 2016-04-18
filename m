From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Apr 2016 16:47:46 -0700
Subject: Nokia N900 retention mode in v4.6, camera buttons fun
In-Reply-To: <20160417175539.GA502@amd>
References: <20160407213229.GO16484@atomide.com> <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com> <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd> <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd> <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com> <20160417175539.GA502@amd>
Message-ID: <20160418234746.GY5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [160417 10:56]:
> > The off mode makes a huge difference for standby time, it should cut
> > down the total power consumption to something like 10+ mW with modem
> > enabled. Aproximately the breakdown is roughly: 900 uW for omap, 5 mW
> > for memory and 5 or more for the modem. Sorry I don't know the exact
> > numbers for the modem. But with 37xx torpedo, mainline kernel is
> > already getting very close to the 900 uW + 5 mW numbers for the CPU
> > module during idle measured from the ina219 shunt on the torpedo
> > devkit.
> 
> CONFIG_HSI breaks power management completely, so power management
> with modem will be another topic.  

OK

> > > > In the meantime, I found what is causing the rention mode to break for
> > > > me: CONFIG_HSI (aka wireless modem support). With HSI off, it seems to work.
> > > > 
> > > > I still get problems with the camera button, in config similar to
> > > > defconfig.  For some reason, I'm even getting (autorepeating) ^@ on
> > > > console. As long as I hold camera button down, I even get it into off
> > > > mode for brief period.
> > > 
> > > Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
> > > mode... once per screen blank, for about a second. (Does CONFIG_KEYBOARD_GPIO also cause
> > > problems for you?)
> > > 
> > > Any idea why it enters off mode only once after each screenblank?
> > 
> > After disabling CONFIG_PROVE_LOCKING, loading the LCD modules, and
> > blanking the screen, my n900 hits off mode just fine about once
> > a second. Sounds like you still have some extra devices enabled
> > causing it.
> 
> I checked again... also with vanilla 4.6-rc2 to double check... same effect.
> 
> Aha, got it... cat-ing /sys/kernel/debug/pm_debug/count breaks the
> off mode. If I don't do that (tm), it seems to work way better.

Ah I see yeah :)

Regards,

Tony
