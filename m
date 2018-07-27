From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jul 2018 13:32:15 +0200
Subject: Droid 4: suspend to RAM?
In-Reply-To: <20180725212853.GA1965@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
Message-ID: <20180727113214.GA32069@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > > high even before modem (and thus USB) is enabled.
> > >
> > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > consumption than stock operating system.
> > >
> > > (My Linux can survive for 10 hours, stock system could survive for 4
> > > days if I'm not mistaken).
> > >
> > > I thought I would experiment with suspend to RAM.. and it indeed
> > > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > > wakeup with button somehow? Is suspend to RAM required for good power
> > > consumption?
> > 
> > Sorry but pm subsystem has debug mode that you can test in a easy way.
> > You can even wakeup by any rtc alarm easily.
> 
> Yes, that is how it works on PC (but there power button works,
> too). Is it expected to work on Droid in v4.18?

I tried setting up wakeup using RTC, but no, it does not seem to work:

root at devuan:/my/tui/d4# rtcwake -m no -s 5
rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
root at devuan:/my/tui/d4# echo mem > /sys/power/state

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/970666f8/attachment.sig>
