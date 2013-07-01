From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 1 Jul 2013 11:42:58 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <51D14333.40307@gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com>
Message-ID: <20130701094258.GT18285@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 10:52:03AM +0200, Sebastian Hesselbarth wrote:
> On 07/01/13 02:01, Dave Airlie wrote:
> >how about instead of writing:
> >"However, at least I've taken the time to_think_  about what I'm doing
> >and realise that there_is_  scope here for the DRM core to improve,
> >rather than burying this stuff deep inside my driver like everyone else
> >has.  That's no reason to penalise patches from the "good guys" who think"
> >
> >you go with
> >"I noticed this piece of functionality could be refactored, here is a
> >patch adding them to
> >the core, does anyone think its a good idea?"
> 
> Dave,
> 
> at least on this point I do share Russell's impression. I've sent
> bunch of patches improving TDA998x and DRM+DT:
> - TDA998x irq handling - ignored
> - TDA998x sync fix - ignored
> - Fix drm I2C slave encoder probing
> 
> I am aware that this is not an easy job nor one you get much
> appreciation for. But, back when TDA998x driver was published,
> all my comments were basically answered with "Oh, I know. Maybe
> someday somebody will fix it".

I guess part of the problem here is that in the arm world we don't (yet)
have many full-blown drivers and not many people to fix up stuff or chime
in with good review. And sometimes that just means that someone puts down
his foot and says "this is how we do it" - at least for drm/i915 I
sometimes have to do that to unblock a massive bikeshed-fest.

> I am not being paid for any of this, but have a strong intrinsic
> motivation here. But I am loosing interest in sending fixes for
> DRM stuff because my (personal) impression is the same Russell
> has: Depending on who sends patches, they get merged independent
> of how broken they are - others are discussed to death.

Hm, we run fairly extensive QA for drm/i915, and thus far the drm core
stuff hasn't really blown up badly for us. So can you please point at
examples where crap was merged and shouldn't have been?

Wrt to bikeshed to death I know that drm folks are a bit prone to that (me
included), but recently I haven't spotted a case where this happened. ARM
stuff excluded ofc since I don't follow that too closely. There's also
that Dave is sometimes a bit swamped, but pinging him on irc about lost
patches works well (at least for stuff I care about).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
