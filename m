From: alexdeucher@gmail.com (Alex Deucher)
Date: Mon, 20 May 2013 16:23:33 -0400
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130520201536.GY18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
 <20130519085920.GO18614@n2100.arm.linux.org.uk>
 <CADnq5_Pajy4jxLdd9QGBrUooWYFjfQRQgdbvbu9UDE8-7Tmm8g@mail.gmail.com>
 <20130520201536.GY18614@n2100.arm.linux.org.uk>
Message-ID: <CADnq5_O8nLi1=HOrXO0AeQuX17tGj05fhao4mmauzZ5h8Ciyaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 4:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 20, 2013 at 09:36:02AM -0400, Alex Deucher wrote:
>> You can tell the xserver what size cursor you support when you call
>> xf86_cursors_init() in the ddx.  Just expose a 32x64 or 64x32 ARGB
>> cursor.  Most apps don't use a 64x64 cursor anyway.  I've used
>> hardware with non-64x64 cursors and haven't run into any problems yet.
>
> I guess the xf86 backend will fall back to software cursors if it gets
> a cursor larger than the hardware supports, so maybe 64x32 will be
> fine.
>
> However, my comments concerning the less-than-64x64 size come from
> David Airlie who said "X and userside programs expect 64x64 to work.
> so its possibly pointless supporting anything less, as in you'd write
> code but nobody would end up using it".
>
> Note also that the generic DRM KMS code assumes cursor support at
> 64x64, and there's no generic way for a driver at present (that I know
> of) to inform it of anything different.

It shouldn't be too hard to add a new cap for querying the cursor size
to the drm cap interface.

Alex
