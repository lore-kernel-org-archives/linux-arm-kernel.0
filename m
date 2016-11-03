From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 3 Nov 2016 10:57:58 +0100
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <20161019131145.GA11036@leverpostej>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej> <20161019094227.GB1461@amd>
 <20161019131145.GA11036@leverpostej>
Message-ID: <20161103095758.GA7973@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2016-10-19 14:11:45, Mark Rutland wrote:
> On Wed, Oct 19, 2016 at 11:42:27AM +0200, Pavel Machek wrote:
> > On Tue 2016-10-18 11:45:39, Mark Rutland wrote:
> 
> > Either the lowlevel suspend code is stable and bug free, and then
> > having that code is not a problem.
> 
> This ignores the cost of maintaining that code. Kernel APIs change over
> time, and no code is ever completely stable, even if at one point in
> time it happens to be bug-free.

Well, kernel interfaces only change when there's good reason for a
change, and if you force stable binary interface to external
component, and there _is_ need for a change, we are all screwed.

> > BSD is better than closed source, but it also means that you will not
> > get the sources from your hw vendor.
> 
> That depends on your hardware vendor, as always. There are a number of
> platform ports in the upstream ATF repo.
> 
> It's also worth considering that a number of 32-bit arm parts require
> closed firmware (as far as I can tell, including the N900).

Yeah, but we are trying to remove closed firmware. Don't make people
add more of it...

> > Being separate module means it will be hard to debug, in area where
> > debugging is already pretty hard.
> 
> It can be harder, yes. There are also benefits, given the same code can
> be tested on a variety of platforms.

What benefits? You are able to share code between platforms in kernel,
too.

> > Can it do advanced stuff like deep powersaving on N900 idle?
> 
> Sorry, I don't know precisely what you're referring to.
> 
> It can do things like shutting down entire CPU clusters (and IIRC
> associated interconnect) when all relevant CPUs are idle, if that's what
> you mean.

I mean equivalent power savings between idle system and system in
s2ram.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/b3b419d1/attachment.sig>
