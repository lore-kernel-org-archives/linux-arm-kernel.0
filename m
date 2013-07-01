From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 01 Jul 2013 12:50:59 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130701094258.GT18285@phenom.ffwll.local>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com> <20130701094258.GT18285@phenom.ffwll.local>
Message-ID: <51D15F13.7040408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/13 11:42, Daniel Vetter wrote:
> On Mon, Jul 01, 2013 at 10:52:03AM +0200, Sebastian Hesselbarth wrote:
>> at least on this point I do share Russell's impression. I've sent
>> bunch of patches improving TDA998x and DRM+DT:
>> - TDA998x irq handling - ignored
>> - TDA998x sync fix - ignored
>> - Fix drm I2C slave encoder probing
>>
>> I am aware that this is not an easy job nor one you get much
>> appreciation for. But, back when TDA998x driver was published,
>> all my comments were basically answered with "Oh, I know. Maybe
>> someday somebody will fix it".
>
> I guess part of the problem here is that in the arm world we don't (yet)
> have many full-blown drivers and not many people to fix up stuff or chime
> in with good review. And sometimes that just means that someone puts down
> his foot and says "this is how we do it" - at least for drm/i915 I
> sometimes have to do that to unblock a massive bikeshed-fest.
>
>> I am not being paid for any of this, but have a strong intrinsic
>> motivation here. But I am loosing interest in sending fixes for
>> DRM stuff because my (personal) impression is the same Russell
>> has: Depending on who sends patches, they get merged independent
>> of how broken they are - others are discussed to death.
>
> Hm, we run fairly extensive QA for drm/i915, and thus far the drm core
> stuff hasn't really blown up badly for us. So can you please point at
> examples where crap was merged and shouldn't have been?

Don't get me wrong, "broken" above didn't mean it doesn't work at all,
but with SoC graphic drivers arising, requirements shift from "some
known implementations" to "you never know what will be combined with
e.g. a specific CRTC". So from that latter point-of-view, I consider
TDA998x for example as broken. It may work with tilcdc in some modes,
but as Darren Etheridge stated, it breaks as soon as you touch TDA998x
driver. At least for that, I confirmed the timings of Russell's driver
and the fixes posted with a scope and a bunch of modes and monitors/tv.

For the timing fix of TDA998x, Darren now is trying to also confirm
every single sync line of tilcdc and I really like to see his Tested-by
on the patch - just because Russell's driver and the CuBox are the only
testbeds I have on this.

> Wrt to bikeshed to death I know that drm folks are a bit prone to that (me
> included), but recently I haven't spotted a case where this happened. ARM
> stuff excluded ofc since I don't follow that too closely. There's also
> that Dave is sometimes a bit swamped, but pinging him on irc about lost
> patches works well (at least for stuff I care about).

Hmm, I understand that it is _very_ time consuming work on your side.
But for me - with limited insight of DRM core - it is not a good starter
to make the API DT aware. The DRM API documentation _is_ limited wrt
intentions of the way it is done.

Of course, I share the idea of true, full-blown of_drm_something
helpers. But the DT patch, is not an improvement but a real fix as in
"make DRM not break on some platforms". From that on, I can start
digging into DRM API and improve DT support here and there.

So for the three patches I mentioned above, they are all minor
improvements of the API. Minor, because I cannot ever sent _the_ single
perfect patch just because I don't know the API well enough, yet.

Just based on my personal experience: TDA998x driver got merged the way 
it is _although_ I addressed some concerns - the fixes are not merged
_although_ I provided experimental results. This is of course
disappointing for me, but I am sure it will work out soon and I will
get back to happily send improvements for the platforms I can test on.

Sebastian
