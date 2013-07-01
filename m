From: robdclark@gmail.com (Rob Clark)
Date: Mon, 1 Jul 2013 17:55:08 -0400
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <51D14333.40307@gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com>
Message-ID: <CAF6AEGuJZeFBKgnTa8NM82jsfyx1wuyRcVnb9g2fqrZ+1LSuKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 4:52 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 07/01/13 02:01, Dave Airlie wrote:
>>
>> how about instead of writing:
>> "However, at least I've taken the time to_think_  about what I'm doing
>> and realise that there_is_  scope here for the DRM core to improve,
>>
>> rather than burying this stuff deep inside my driver like everyone else
>> has.  That's no reason to penalise patches from the "good guys" who think"
>>
>> you go with
>> "I noticed this piece of functionality could be refactored, here is a
>> patch adding them to
>> the core, does anyone think its a good idea?"
>
>
> Dave,
>
> at least on this point I do share Russell's impression. I've sent
> bunch of patches improving TDA998x and DRM+DT:
> - TDA998x irq handling - ignored
> - TDA998x sync fix - ignored

At least the sync fix, looks like I missed it (it probably is a good
idea to CC me if you want me to look at it).  Looks like there was
some follow-up discussion on both patches, unless I missed seeing a
newer version of those patches.

Sometimes if you think a patch has been ignored/forgotten, it doesn't
hurt to ping on mailing list or #dri-devel..  a lot of us are working
not just on kernel (the relatively small part in the whole linux
graphics stack), but also mesa and/or x11.  Some times things end up
several pages down in the mail folder.  It's not because we are all
sitting on a beach drinking margaritas, or because we don't like you.
It is just because we are busy and missed it.

Last few months I've been pretty buried in r/e + gallium driver for
new gpu, so I wasn't always checking dri-devel list every day.  At
least now I am in drm-driver mode again ;-)

> - Fix drm I2C slave encoder probing
>
> I am aware that this is not an easy job nor one you get much
> appreciation for. But, back when TDA998x driver was published,
> all my comments were basically answered with "Oh, I know. Maybe
> someday somebody will fix it".

If you have a better idea about how to make the slave encoder probing
better (and/or more generic to support stuff other than i2c), please
send RFC patch.  (And if you already did this, please send updated
version, see previous point about sometimes missing patches.)


BR,
-R


> I am not being paid for any of this, but have a strong intrinsic
> motivation here. But I am loosing interest in sending fixes for
> DRM stuff because my (personal) impression is the same Russell
> has: Depending on who sends patches, they get merged independent
> of how broken they are - others are discussed to death.
>
> Sebastian
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
