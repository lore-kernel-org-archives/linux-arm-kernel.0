From: robdclark@gmail.com (Rob Clark)
Date: Tue, 8 Oct 2013 08:07:23 -0400
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131008111913.09bfe93e@armhf>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
 <CAF6AEGsqGYj7_tZdzrsmUxExs6wm838dYPFhBdc8wqVC6mTxmg@mail.gmail.com>
 <20131008111913.09bfe93e@armhf>
Message-ID: <CAF6AEGtQLL_c3zLS+S83jm505O_fcCm2mKW+Kd-oWP8EgpwzSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 5:19 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Mon, 7 Oct 2013 10:59:39 -0400
> Rob Clark <robdclark@gmail.com> wrote:
>
>> Jean-Fran?ois, just as an aside, I really don't think code that can be
>> shared, like tda998x, should encode a DT requirement.. there are
>> plenty of platforms that don't use DT (arm isn't everything, and last
>> I heard aarch64 was going to be ACPI).
>>
>> Beyond that, it is a driver decision whether or not to support only-DT
>> or DT + other.. and as long as there is a common board which can use
>> the driver but which is not DT, there is probably a compelling reason
>> to still support the non-DT case.
>
> Rob,
>
> The Cubox is an open platform, and I use it just like a desktop PC.
> When its required drivers will be in the mainline, I will do the same
> as I do with PCs: I will not recompile a specific kernel each time
> there are kernel bugs or security issues. Instead, I will just upgrade
> my system from my distributor (Debian), and, in the packages, there
> will be a generic mvebu kernel as there is already one for Marvell
> Armada 370/xp, Freescale iMX5x/iMX6 (linux-image-3.10-3-armmp).
> But, for that, all the Cubox specific stuff must be described in a DT.

sure, I'm not saying *not* to support DT (send patches if need be).
I'm just saying that it should be ok to also support non-DT case and
that shared components (like tda998x) should also still work in non-DT
case.

BR,
-R

> --
> Ken ar c'henta? |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
