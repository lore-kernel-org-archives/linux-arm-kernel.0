From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 26 Apr 2015 12:13:59 +0200
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <CANOLnONc3+F=e3VfYZyGCtnzMOHV3GrX6cUSV1G4WJDPrgGFSg@mail.gmail.com>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
 <20150306224034.GA20559@amd> <201503062356.06110@pali>
 <CANOLnONc3+F=e3VfYZyGCtnzMOHV3GrX6cUSV1G4WJDPrgGFSg@mail.gmail.com>
Message-ID: <20150426101359.GA3933@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> Ok, but:
> >>
> >> 1) Why is the twl4030-bci enabled in n900's dts, then
> >>
> >
> > maybe it is bug in n900 dts...
> >
> > Grazvydas, is there some runtime check if twl4030/twl5030 chip
> > has charger or not? or do we need to explicitly disable device
> > twl4030-bci in DT?
> 
> Actually from looking at the schematics, it looks like the charger
> pins are still there but all connected to ground. So it probably has
> the charger after all, it's just not connected or used.
> 
> I'm not aware or any registers for direct detection, and indirect
> detection is difficult because BCI mostly disables itself when no
> charger is connected and most registers read as 0 or have old values
> from last charging session (which will never happen on n900).
> 
> There is IDCODE register on twl4030 itself, but it's documented as not
> meaningful when accessed over i2c (when is it meaningful then??).
> 
> drivers/mfd/twl-core.c has a i2c_device_id table of various twl4030
> variants, some of which have no charger. N900 has GAIA/twl5030, which
> differs from twl4030 only by vaux2 regulator according to that file.
> N900's old board files specify 5030, but .dts does not.

I have enabled the (not-too-useful) twl4030 charger on my n900, and
it seems to break boot with kernels
34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085 and newer.

I'll probably not have time to investigate it further (charger not
connected to anything is not too useful), but maybe Neil wants to test
on his phone...?
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
