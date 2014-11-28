From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 28 Nov 2014 20:09:09 +0530
Subject: [PATCH] arm64: enable ARCH_HAS_BANDGAP config
In-Reply-To: <20141128141240.GA4249@localhost>
References: <1415968254-5182-1-git-send-email-a.kesavan@samsung.com>
 <CAGOxZ52o-O+=PCsGRfKEGGc0NUg_M+z5_UmbrjBwvW8+x3c22w@mail.gmail.com>
 <20141128141240.GA4249@localhost>
Message-ID: <CAM4voamq0KpLU4-5vKeV5eyHeT9tTP3wGzrH5KNsnR8maSS5Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Nov 28, 2014 at 7:42 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Sun, Nov 23, 2014 at 08:05:05AM +0000, Alim Akhtar wrote:
>> On Fri, Nov 14, 2014 at 6:00 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>> > Some of the existing thermal drivers (ti and exynos) have a dependency on
>> > ARCH_HAS_BANDGAP. Activate ARCH_HAS_BANDGAP config entry for ARM64 so that
>> > these drivers may be re-used.
>> >
>> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> > ---
>> HAS_BANDGAP was added to ARM to indicate that arch supports a bandgap
>> device like a thermal management unit, so this looks good to me.
>
> But it doesn't look good to me. ARCH_HAS_* kind of implies that the
> architecture has some feature or the port provides some feature. But in
> the current use, it simply allows the enabling of the menu config
> entries for two drivers (EXYNOS_THERMAL and TI_SOC_THERMAL).
>
> If you want to specify that the SoC has a device, just use DT and not
> some random config option that only enables the menu entry for the
> corresponding driver.

So, you are suggesting that the ARCH_HAS_BANDGAP dependency for these
two drivers be removed ? I am not aware of the history behind adding
this symbol, but as it is only used  by the 2 platforms it should be
easy to remove.

Regards,
Abhilash
>
> --
> Catalin
