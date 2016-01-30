From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 30 Jan 2016 21:02:45 +0100
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160126172527.GY3500@atomide.com>
References: <20160123121022.GB12497@amd> <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd> <20160126172527.GY3500@atomide.com>
Message-ID: <20160130200244.GA30429@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > ffdffe8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200072
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > 
> > cm_idlest1_core changes periodicall often, to 00218072. The rest seems
> > constant.
> 
> For cm_idlest1_core 42 is the answer.. Here you have bits 4 and 5
> blocking which is for OTG and it's PHY. That's a known issue with
> musb and setting pm_runtime_irq_safe() on the MUSB parent.
> 
> If you do rmmod omap2430 and phy-twl4030usb chances are the LEDs will
> start going off assuming the McSPI bit goes low with WLAN idling.

Ok, so I tried to compile kernel without omap2430/phy-twl4030usb
. That did not help. So I thought, ok, maybe rmmod is needed to
trigger some powersaving? But that is not exactly easy to do:

pavel at n900:/my/tui/ofone$ sudo insmod /my/modules/omap2430.ko
pavel at n900:/my/tui/ofone$ sudo insmod /my/modules/phy-twl4030-usb.ko
pavel at n900:/my/tui/ofone$ sudo rmmod phy-twl4030-usb.ko
Error: Module phy_twl4030_usb is in use
pavel at n900:/my/tui/ofone$

Any ideas what jumps to use the modules? Charger code?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
