From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 25 Jul 2018 23:28:53 +0200
Subject: Droid 4: suspend to RAM?
In-Reply-To: <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
Message-ID: <20180725212853.GA1965@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI!
> >
> > I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
> > have no idea why. Second is power consumption -- it seems to be rather
> 
> Depend how do you set the SMS buffering using CNMI if I remember. Modem
> has 1024bytes of memory most of the time that can buffer more then 1 sms.
> Modem rise a irq when they receive a call or sms, or you an use the serial but
> omap family can loose the first char coming from the serial so you can lost the
> sms because parsing fail

I am using USB connection to the modem. And yes, I'm using rather
strange CNMI settings (but other did not work).

> > high even before modem (and thus USB) is enabled.
> >
> > Interestingly, CyanogenMod and Jolla seem to have higher power
> > consumption than stock operating system.
> >
> > (My Linux can survive for 10 hours, stock system could survive for 4
> > days if I'm not mistaken).
> >
> > I thought I would experiment with suspend to RAM.. and it indeed
> > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > wakeup with button somehow? Is suspend to RAM required for good power
> > consumption?
> 
> Sorry but pm subsystem has debug mode that you can test in a easy way.
> You can even wakeup by any rtc alarm easily.

Yes, that is how it works on PC (but there power button works,
too). Is it expected to work on Droid in v4.18?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180725/7630565b/attachment.sig>
