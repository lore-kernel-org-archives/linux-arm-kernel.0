From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 23 Jan 2016 13:04:25 +0100
Subject: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
In-Reply-To: <201601212034.07727@pali>
References: <20160121184234.GA17679@amd>
 <201601212034.07727@pali>
Message-ID: <20160123120424.GA12497@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2016-01-21 20:34:07, Pali Roh?r wrote:
> On Thursday 21 January 2016 19:42:34 Pavel Machek wrote:
> > Hi!
> > 
> > In 4.4, n900 battery charging works. If indicator is turned off, it
> > stays off, and if I select 1.8A charge, it sticks. (There may be
> > problems after system suspend and resume. But normal operation seems
> > to be pretty reliable).
> 
> Hm... right, bq2415x driver does not have support for suspend/resume. 
> Before suspend registers should be stored and after resume restored, 
> plus check charger auto detection.
> 
> > In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery
> > charging works for few hours. But then indicator (yellow light on
> > 3color LED) turns back on, and if I ask for 1.8A charge, it goes
> > back to .1A, discharging battery.
> > 
> > Any ideas?
> 
> Look into bq24150a sysfs node what changes. Also if there is something 
> in dmesg.

Hmm, seems like I can't reproduce that any more. I now noticed that if
I suspend machine it auto-resumes quickly, so maybe suspend was
responsbile. I'll try running 4.5-rc0 for a while...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
