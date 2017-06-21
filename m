From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 21 Jun 2017 20:08:47 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170621123535.b5fvwlydfhnhuqll@piout.net>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
 <20170621075152.GA15996@amd>
 <20170621083907.y3gadsmsoufa5niv@piout.net>
 <20170621063443.GA4862@localhost>
 <20170621123535.b5fvwlydfhnhuqll@piout.net>
Message-ID: <20170621180847.GA24175@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Or not, having an RTC set in the past is actually quite common. I'd find
> > > it weird to have a new device boot and be set to a date in the future.
> > 
> > ...but still better than board stuck in the past, no?
> > 
> > > Also note that the threshold or offset thing may seem like a good idea
> > > but fails with many RTCs because of how they handle leap years.
> > 
> > Well, you can still convert time from rtc to unix time, then do adjustment
> > there.
> > 
> 
> You can only if your machine is running when that happens. If that is
> not the case, then you lost and your time is not correct anymore.

I don't see why that should be a case... as long as you know what RTC
does in event of overflow, and it is not something completely crazy.

> > Anyway, I guess it would be cool for rtc drivers to annotate what limits
> > underlying storage has to the common code, so that we can do fixups once
> > per class, not once per driver.
> 
> Yes, I'm in the middle of the whole rework that allows that.
> 
> I don't understand the sudden urgency of fixing that and the amount of
> bikeshedding, seeing that the closest cutoff date is actually 31st of
> december 2069 in the rtc subsystem and that anyway the current 32bit
> userspace will explode in february 2038.
> 
> My plan from the beginning was to have something for the next stable. I
> know nobody can read my mind but again, I don't think there is currently
> any urgency to change anything.

Yes, mind reading is a problem. I can only read minds of ferungulates,
and only if they are physicaly near me :-).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/cd332894/attachment.sig>
