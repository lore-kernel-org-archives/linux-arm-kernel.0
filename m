From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 19 Oct 2016 11:42:27 +0200
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <20161018104539.GB15639@leverpostej>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej>
Message-ID: <20161019094227.GB1461@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-10-18 11:45:39, Mark Rutland wrote:
> On Tue, Oct 18, 2016 at 12:00:02PM +0200, Pavel Machek wrote:
> > > >b. in arm64, if some platform has its own suspend flow,  couldn't it
> > > >adopts arm/match-xxx to register its own global suspend method?
> > > 
> > > No, PSCI is highly recommended.
> > 
> > Relying on firmware for suspend on x86 was a great disaster, lets not repeat
> > that mistake. arm32 has better powermanagement than x86 ever will (see Nokia N900
> > for example) -- feel free to copy that code from arm32.
> 
> Quite frankly, copying hundreds of lines of board-specific code
> (including assembly that won't compile) is unlikely to help.
> 
> So far arm64 requires well-defined, standard, reusable interfaces (e.g.
> PSCI). That cleanly separates concerns (e.g. anyone can implement the
> backend without mandatory changes to the kernel), and keeps things
> maintainable.

Either the lowlevel suspend code is stable and bug free, and then
having that code is not a problem. Or the lowlevel suspend code is
complex enough to contain some bugs, and in such case it is better to
debug and update it with kernel.

> ARM publishes and maintains the ARM Trusted Firmware [1], which anyone
> can use and build atop of. It's open source (three-clause BSD with DCO),
> and accepts board ports. You can have a completely open stack,
> regardless of whether part of that stack is firmware.

If something is called "Trusted", it is not trustworthy.

BSD is better than closed source, but it also means that you will not
get the sources from your hw vendor.

Being separate module means it will be never updated.

Being separate module means it will be hard to debug, in area where
debugging is already pretty hard.

Can it do advanced stuff like deep powersaving on N900 idle?

Just don't do it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161019/05d8de63/attachment.sig>
