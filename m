From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 21 Jan 2016 20:41:26 +0100
Subject: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
In-Reply-To: <20160121191525.GA26215@earth>
References: <20160121184234.GA17679@amd>
 <20160121191525.GA26215@earth>
Message-ID: <20160121194126.GB13448@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2016-01-21 20:15:25, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 21, 2016 at 07:42:34PM +0100, Pavel Machek wrote:
> > In 4.4, n900 battery charging works. If indicator is turned off, it
> > stays off, and if I select 1.8A charge, it sticks. (There may be
> > problems after system suspend and resume. But normal operation seems
> > to be pretty reliable).
> > 
> > In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery charging
> > works for few hours. But then indicator (yellow light on 3color LED)
> > turns back on, and if I ask for 1.8A charge, it goes back to .1A,
> > discharging battery.
> > 
> > Any ideas?
> 
> Maybe a side-effect of isp1704 driver actually doing what was
> intended, which is is 88025632515a ("power: isp1704_charger: Fix
> isp1704_write()").

Hmm. It looks like 7fdec82af6a does not yet contain 88025632515a. Let
me try to add that fix, instead...

> P.S.: No need to Cc me two times and when you update your
> script/contacts, please use sre at kernel.org :)

Address book updated :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
