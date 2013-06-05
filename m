From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Jun 2013 16:01:58 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzJdIGh3bW9uOiBtYzEzNzgzLWFkYzogUmVmYWN0?=
 =?UTF-8?B?b3Igc291cmNlIHRvIGluZGljYXRlIHZhcmlvdXMgbWMxM3h4eCBjaGlwcw==?=
In-Reply-To: <20130605134530.12e8b7c2@endymion.delvare>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <1370430879.384973987@f91.mail.ru>
 <20130605134530.12e8b7c2@endymion.delvare>
Message-ID: <1370433718.509579856@f214.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




?????,  5 ???? 2013, 13:45 +02:00 ?? Jean Delvare <khali@linux-fr.org>:
> On Wed, 05 Jun 2013 15:14:39 +0400, Alexander Shiyan wrote:
> > > Let's look at it from another angle. What problem are you trying to
> > > solve? I see absolutely no problem with the current function and file
> > > names. Almost all Linux kernel drivers support more chips than their
> > > name says.
> > > 
> > > On the other hand, changing all function names makes backporting fixes
> > > harder, and changing Kconfig symbol names makes upgrading to the new
> > > kernel version harder for everyone.
> > > 
> > > So the cost of your proposal far outweighs the benefits.
> > 
> > Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
> > symbols in the log (debug) will say a developer who does not know about
> > mc13892 compatibility with mc13783? I still believe that this should be reflected.
> 
> You're splitting hairs here. mc13783_* symbols in the log mean this
> comes from a driver named mc13783, period. A developer drawing
> conclusions beyond that needs to be educated. Which device the driver
> is driving can be retried from the log itself, or from sysfs. Or the
> hardware board datasheet. "mc13xxx" would tell no more, BTW.
> 
> Also note that the name mc13xxx is wrong as well, as the mc13xxx-i2c
> and mc13xxx-spi drivers handle the MC34708 chip too. So you'd have to
> name all these drivers and functions mcxxxxx* to cover all the
> supported chip. Which makes no sense at all, because so many x's are
> confusing, and because the mask then matches many devices the drivers
> do _not_ handle.
> 
> So please forget about this and move on to something else. There are
> many many code cleanups and improvements, and bug fixes, all way more
> important than this. So I'm sure you can find better ways to spend your
> time, and mine.

Agree, we have a lot of places in the kernel to be cleared.
For the same driver MC13XXX, at least we need to remove a useless symbol
MFD_M13783 which is selected automatically if we select MFD_MC13XXX, 
mc13xxx_lock/unlock functions in the driver has long been not needed because
we use regmap etc.
But to start in my opinion you need with just such trifles as rename etc...
But even at this stage of obstacles have come up against ...
Well, by and large it does not change code but rather a grooming code, 
so I can easily give it up. But, in my opinion, the purity and clarity of the code
has never harmed.
OK, lets drop these patches.
Thanks.

---
