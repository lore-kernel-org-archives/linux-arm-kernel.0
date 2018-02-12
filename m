From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Feb 2018 16:26:18 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <20180112153903.GB5992@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
Message-ID: <20180212152618.GC13962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Let's restart this discussion and focus on the main roadblock (others
> > are minor details which can be sorted out later).
> > 
> > If it feels like a hack, the key issue seems to me to be the choice of
> > the API to present the GPS data to user space. Right?
> 
> Or even more fundamentally, does this belong in the kernel at all?

Yes, it does.

> Given that we'd still depend on gpsd and other, proprietary, daemons to
> actually parse and use (also for control) the plethora of GPS protocols
> available, it may even be best to just keep it all in user space.

No. We'd want to move away from gpsd in the long
term. (/dev/input/mice was in similar situation.)

> Now, if we'd ever have a proper GPS framework that handled everything in
> kernel space (i.e. no more gpsd) then we would be able to write kernel
> drivers that also take care of PM. But perhaps that's unlikely to ever
> be realised given the state of things (proprietary protocols, numerous
> quirky implementations, etc).

That is what needs to happen.

> The kernel is probably not the place to be working around issues like
> that, even if serdev at least allows for such hacks to be fairly
> isolated in drivers (unlike some of the earlier proposals touching core
> code).

Oh, kernel is indeed right place to provide hardware abstraction --
and that includes bug workarounds.

We'd like unmodified userspace to run on any supported hardware,
remember?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/24d60393/attachment.sig>
