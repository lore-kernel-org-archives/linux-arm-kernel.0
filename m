From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 May 2016 14:03:22 -0700
Subject: Reverting ARCH_SUNXI arm64 support(?)
In-Reply-To: <20160509205716.GG3733@lukather>
References: <57304FF7.3080909@arm.com> <20160509090951.GC19763@arm.com>
 <5730714C.7010608@arm.com> <20160509205716.GG3733@lukather>
Message-ID: <CAOesGMiAeG1Sy1efAMVQxkRu-Wh7UY-awUcPPQPQ3BKswsYN5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 1:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, May 09, 2016 at 12:15:24PM +0100, Andre Przywara wrote:
>> Hi,
>>
>> On 09/05/16 10:09, Will Deacon wrote:
>> > On Mon, May 09, 2016 at 09:53:11AM +0100, Andre Przywara wrote:
>> >> Hi Will, Catalin,
>> >
>> > Hi Andre,
>> >
>> >> Suzuki reported a build failure with certain (non-defconfig) .configs
>> >> due to the new ARCH_SUNXI support in 4.6-rc [1].
>> >> As unfortunately we couldn't agree on a solution and also the support
>> >> for the A64/Pine64 is partial in 4.6 anyway, can you please revert:
>> >> ce3dd55b99b151a90ac1701c6825f2ae2d49b54e ("arm64: Introduce Allwinner
>> >> SoC config option")
>> >
>> > Given that we (Catalin and I) didn't commit that patch, it seems weird
>> > that we should be reverting it. Shouldn't this be handled in arm-soc or
>> > via the sunxi subtree?
>> >
>> > We're also a week from the merge window, so it doesn't seem like a good
>> > time to be hacking at .config/kconfig-related issues.
>>
>> I agree, that's why I was proposing taking Suzuki's first patch:
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index efa77c1..521b1ec 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -2,6 +2,7 @@ menu "Platform selection"
>>
>>  config ARCH_SUNXI
>>       bool "Allwinner sunxi 64-bit SoC Family"
>> +     select GENERIC_IRQ_CHIP
>>       help
>>         This enables support for Allwinner sunxi based SoCs like the A64.
>>
>>
>> This is what defconfig selects anyway and also the change would be
>> confined to this (new) config option.
>>
>> Olof, Arnd: would it be an option to take this patch still?
>
> FWIW, I'd be in favour for such patch as a late patch for 4.6.
>
> We can always fix things up properly in a later patch for 4.7 or 4.8.

+1. Please send said patch to arm at kernel.org and we can apply it (cc
Maxime so he can cc) and send up.


-Olof
