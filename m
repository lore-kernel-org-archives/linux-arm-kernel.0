From: robdclark@gmail.com (Rob Clark)
Date: Sat, 18 May 2013 15:11:03 -0400
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <20130518205845.2dfe9fe5@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf>
Message-ID: <CAF6AEGuvte+tfWwC-zDG=TeAo0Qh9-sN-K+0oMTGGa9kBUntOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 2:58 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Sat, 18 May 2013 14:23:19 -0400
> Rob Clark <robdclark@gmail.com> wrote:
>
>> > These parameters should not be there. It seems to me that the DT is the
>> > right place.
>>
>> You might not want to directly have a hard DT dependency in tda998x,
>> as the encoder could be used on non-DT platforms.  Although a DT to
>> encoder-params helper might be a nice idea for platforms which do have
>> DT.
>
> If I correctly understand:
>
> - Russell does not use any DT, so his drm driver should be declared in
>   some cubox-setup code in mach-dove/
>
> - this code should also declare the tda998x
>
> - the drm driver contains/passes parameters to the tda998x
>
> As the connection Dove LCD <-> tda998x is Cubox specific, the question
> is: why are'nt the tda998x parameters in the cubox-setup code?

ok, maybe I am misunderstanding you.  I think the parameters should be
filled in by the board file on a non-DT setup.  But the part in
drivers/gpu/drm/i2c should not pull them directly out of DT, or should
have an arrangement like

 #ifdef CONFIG_OF
 .. pull params out of DT ..
#else
 .. use params passed in from via params struct, which is populated in
board file ..
#endif

to accommodate non-DT builds.  (Although I think just having a helper
to populate 'struct tda998x_encoder_params' from DT seems cleaner.)


BR,
-R

> --
> Ken ar c'henta? |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
