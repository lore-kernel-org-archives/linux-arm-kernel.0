From: wangbintian@gmail.com (Brent Wang)
Date: Fri, 6 Feb 2015 14:35:35 +0800
Subject: [PATCH 0/3] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <CAOesGMhKRtcGwE-5ZKsZC42ZCBYtLV9A0RT0mEySwsU2uk5cSA@mail.gmail.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <CANMBJr685FzZzQ660Z1aNJX+Kzkw1OqM6RJAviARbL+5a=MJ2A@mail.gmail.com>
 <CAOesGMgjv9iLnLmpLADQYoAw=oUkJDAJs72Q5q=DQ75paQ+A-g@mail.gmail.com>
 <CANMBJr7wx=BwDK9inc-2LdXQhyv-tZZry86Ojr=oH8z53Un76Q@mail.gmail.com>
 <CAAS=xmhj8UMwooYrXQBqzR=J5ernj+EWGV1AqEtHHoWiBgw8gA@mail.gmail.com>
 <CAOesGMhKRtcGwE-5ZKsZC42ZCBYtLV9A0RT0mEySwsU2uk5cSA@mail.gmail.com>
Message-ID: <CAAS=xmg9hbv25YPNqoe2xQqEKpj4oxYUtWMA3GAb0nji8bqKmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

2015-02-06 14:18 GMT+08:00 Olof Johansson <olof@lixom.net>:
>
> On Thu, Feb 5, 2015 at 8:21 PM, Brent Wang <wangbintian@gmail.com> wrote:
> > Hello Olof and Tyler,
> >
> > 2015-02-06 7:52 GMT+08:00 Tyler Baker <tyler.baker@linaro.org>:
> >>
> >> On 5 February 2015 at 11:02, Olof Johansson <olof@lixom.net> wrote:
> >> > On Thu, Feb 5, 2015 at 10:46 AM, Tyler Baker <tyler.baker@linaro.org>
> >> > wrote:
> >> >> Hi Bintian,
> >> >>
> >> >> On 5 February 2015 at 01:24, Bintian Wang <bintian.wang@huawei.com>
> >> >> wrote:
> >> >>> Hello,
> >> >>>
> >> >>> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> >> >>> initial support for Hi6220 SoC and HiKey development board, which
> >> >>> is based on ARM Cortex A53 architecture. Initial support is minimal
> >> >>> and includes just the arch configuration, clock driver, device tree
> >> >>> configuration.
> >> >>>
> >> >>> Many peripheral drivers will be submitted later.
> >> >>>
> >> >>> Any comments will be appreciated!
> >> >>>
> >> >>> Thanks,
> >> >>>
> >> >>> Bintian Wang (3):
> >> >>>   arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
> >> >>>   clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
> >> >>>   arm64: dts: Add dts files for Hisilicon Hi6220 SoC
> >> >>
> >> >> Thanks for posting these! I've applied this series on top of
> >> >> next-20150204, however there was some fuzz that needed to be cleaned
> >> >> up on 3/3 [1]. I've confirmed the platform is booting to a basic user
> >> >> space without issue.
> >> >
> >> > From ramdisk only, right?
> >>
> >> Correct, ramdisk only.
> >>
> >> > Given the timing of the posting of this
> >> > patch set, I'm not going to merge it for 3.20. Hopefully for 3.21
> >> > there will be some more peripheral support as well -- at least some
> >> > sort of storage device.
> >>
> >> Seem fair to me. I also hope to see more patches posted shortly.
> >
> > Yes, the mmc and sd drivers will be submitted soon, should they be included
> > in this patchset?  I have thought submitting this patch first for review, if
> > there
> > is no problem for this patchset and then submit other drivers, you know,
> > other
> > drivers will depend on this patchset.
>
>
> The drivers should ideally not depend on the SoC patchset -- the
> driver can go in independently. The DTS updates to specify the
> hardware should go in through arm-soc even if the driver itself (and
> the binding document update) should go in through the driver subsystem
> instead.
>
>
> So, you can choose if you want to post everything as a long series,
> and cc different maintainers on the various parts of the series -- or
> you can post each driver or subsystem as a patchset on its own and let
> that get merged through respective maintainer. The latter is most
> common these days.
I think the latter is a better way, thank you!

>
>
>
> -Olof

-- 
Best Regards,

Bintian
===========================
Don't be nervous, just be happy!
