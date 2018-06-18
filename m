From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 18 Jun 2018 09:40:23 +0200
Subject: Charge counter on droid 4
In-Reply-To: <20180618065827.GN112168@atomide.com>
References: <20180615080014.GA29192@amd> <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
Message-ID: <20180618074023.GA16955@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Droid 4 has non-removable battery, yet the charge counter is reset to
> > > near zero on each boot of linux.
> 
> Not sure if we actively do anything to reset it. I'm guessing
> it's the Motorola bootloader that resets everything on boot.

Too bad if that's the case :-(.

> > > Unfortunately, that makes charge counter pretty much useless on d4, as
> > > the "battery full" and "battery empty" limits will be different during
> > > each boot.
> 
> From what I've seen also the stock kernel starts only with
> voltage based estimate initially after a reboot?
> 
> > Hmm, and could we refrain from providing "power" values?
> > 
> > I was thinking great, we have hardware that does proper power
> > measuerement for us. No.... it is driver providing synthetic
> > values. As userland has enough information to do that itself, I
> > believe we should not do this in kernel.
> 
> Hmm I don't follow you, why would we want to remove these as
> they implement a standard sysfs interface?
> 
> I use the sysfs interface all the time to monitor the power
> consumption and the output seems to match what I was seeing
> with my power supply.

So... there are mA, mAh values. Those come from hardware, and I
believe we should keep them.

But there are also mW, mWh values, which are synthetic. Userland can
compute them from mV, mA values... and it is confusing that kernel
provides them. (My tendency was to start computing these synthetic
values in userland, to compare them with "real hardware" values from
kernel. But then I looked at kernel implementation, and realized they
are synthetic, tooo...)

Best regards,
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/14095185/attachment.sig>
