From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 23 Nov 2015 20:47:48 +0900
Subject: PING: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet
 support for SMDK5410
In-Reply-To: <00d601d125c9$f1231f00$d3695d00$@samsung.com>
References: <00d601d125c9$f1231f00$d3695d00$@samsung.com>
Message-ID: <CAJKOXPd5LCT=p0X+5myyfN=LY6LHwr0yfEQewfEZLC5U-VVEAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-23 17:35 GMT+09:00 Pavel Fedin <p.fedin@samsung.com>:
>  Hello! So what's up? I see SROM driver suddenly removed from everywhere and no single word about it. What is the status?

What do you mean by everywhere? That sounds a little bit drastic... I
did not apply it before at the first place... so if you have in mind
only Kukjin's tree (and linux-next as a result) then indeed - Pankaj's
patches were not accepted during 4.3 merge window, remained in
Kukjin's tree in a separate branch and finally were not included in
current 'for-next' after rebasing over 4.4-rc1 (because they stayed in
separate branch).

As for the current status I reviewed all the patches but, since
Pankaj's work is present in Kukjin's branch, I won't duplicate the
work.

The question is then to Kukjin - what is your plan? Two more patchsets
are depending on it:
1. Pavel's extension of SROM,
2. Pankaj's movement of PM to drivers/soc.

What do you need to apply them?

Best regards,
Krzysztof

>
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
>
>
>> -----Original Message-----
>> From: linux-samsung-soc-owner at vger.kernel.org [mailto:linux-samsung-soc-owner at vger.kernel.org]
>> On Behalf Of Pavel Fedin
>> Sent: Monday, November 16, 2015 10:43 AM
>> To: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-
>> soc at vger.kernel.org; linux-kernel at vger.kernel.org
>> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Kukjin Kim; Krzysztof
>> Kozlowski
>> Subject: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support for SMDK5410
>>
>> This patch extends Exynos SROM controller driver with ability to configure
>> controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
>> which is connected via SROMc bank #3.
>>
>> With this patchset, support for the whole existing SMDK range can be added.
>> Actually, only bank number is different.
>>
>> This patchset also depends on Exynos 5410 pinctrl support, introduced by
>> patches 0003 and 0004 from this set:
>> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
>>
>> Pinctrl support is necessary in order to correctly configure
>> multifunctional pins of the Exynos chip.
>>
>> v8 => v9:
>> - Fixed node suffix in ethernet chip DT node (@3,0 instead of @3)
>>
>> v7 => v8:
>> - More fixes to documentation
>>
>> v6 => v7:
>> - Fixed stupid error in Tacc description in the documentation
>>
>> v5 => v6:
>> - Even more improvements to the documentation, fixed some errors and typos.
>> - Separated adding bus ranges from generic SROMc support
>> - Some stuff renamed for even better code readability
>> - Stylistic cleanups in the DTS (everything in alphabetic order, use named
>>   constant name for interrupt config byte)
>>
>> v4 => v5:
>> - Some cosmetic changes in the dtsi ("compatible" goes first)
>> - Use correctly specified ranges for the SROMc node
>> - Reuse existing properties where possible ("reg" for bank# and
>>   "reg-io-width" for data width)
>> - Separated page-mode property from timings array
>> - More improvements to the documentation
>>
>> v3 => v4:
>> - Devices are now added as subnodes, with additional properties. This allows
>>   to cleary specify dependency. If configuration fails, error will be reported
>>   and child devices will not be probed.
>> - These additional properties now have "samsung,srom-XXX" format
>> - Fixed code style, now better understood.
>>
>> v2 => v3:
>> - Fixed up SROMc region size in the device tree
>> - Reordered patches, documentation goes first now
>>
>> v1 => v2:
>> - Fixed some typos and bad labels in device tree
>> - Improved documentation
>>
>> Pavel Fedin (4):
>>   Documentation: dt-bindings: Describe SROMc configuration
>>   ARM: dts: Add SROMc to Exynos 5410
>>   drivers: exynos-srom: Add support for bank configuration
>>   ARM: dts: Add Ethernet chip to SMDK5410
>>
>>  .../bindings/arm/samsung/exynos-srom.txt           | 73 +++++++++++++++++++++-
>>  arch/arm/boot/dts/exynos5410-smdk5410.dts          | 41 ++++++++++++
>>  arch/arm/boot/dts/exynos5410.dtsi                  | 11 ++++
>>  arch/arm/mach-exynos/Kconfig                       |  2 +-
>>  drivers/soc/samsung/Kconfig                        |  2 +-
>>  drivers/soc/samsung/exynos-srom.c                  | 61 +++++++++++++++++-
>>  6 files changed, 184 insertions(+), 6 deletions(-)
>>
>> --
>> 2.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
