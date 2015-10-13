From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 13 Oct 2015 18:55:21 +0530
Subject: [PATCH v2 0/7] Add support for Exynos SROM Controller driver
In-Reply-To: <55DBD063.5040703@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
 <55DBD063.5040703@samsung.com>
Message-ID: <561D0641.5060205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Tuesday 25 August 2015 07:48 AM, Krzysztof Kozlowski wrote:
> On 24.08.2015 17:02, Pankaj Dubey wrote:
>> This patch set adds support for Exynos SROM controller DT based driver.
>> Currently SROM register sets are used only during S2R, so driver
>> basically added for taking care of S2R. It will help us in removing
>> static mapping from exynos.c and other extra code handline during S2R.
>>
>> This patch set also updated exynos4 and exynos5 dtsi files for with device
>> node for srom, and added binding documentation for the same.
>>
>> First two patches are some minor cleanup in mach-exynos.
>>
>> Patchset v1 was posted here[1]
>> [1]: https://lkml.org/lkml/2015/4/29/98
>>
>> Changes since v1:
>>   - Rebased to latest kgene tree.
>>   - Addressed review comments from Krzysztof Kozlowski.
>>   - Add two new patches for minor cleanup in exynos.c and map.h
>>
>> Pankaj Dubey (7):
>>    ARM: EXYNOS: remove unused static mapping of CMU for exynos5
>>    ARM: EXYNOS: code cleanup in map.h
>>    drivers: soc: add support for exynos SROM driver
>>    ARM: EXYNOS: Remove SROM related register settings from mach-exynos
>>    ARM: dts: add SROM device node for exynos4
>>    ARM: dts: add SROM device node for exynos5
>>    Documentation: dt-bindings: add exynos-srom binding information
>
> One more thing: please update the existing Exynos entry in maintainers
> so it would cover drivers/soc/samsung.
>

Thanks for review, and sorry for late reply.

I have updated v3 version of this patch series addressing most of your 
review comments. Please do let me know if still it has any concern.

Regarding Pavel's comment of handling any other external peripheral 
which can be hooked into srom can be handled as feature addition on top 
of this basic driver based on requirement.

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
>
>>
>>   .../bindings/arm/samsung/exynos-srom.txt           |  12 ++
>>   arch/arm/boot/dts/exynos4.dtsi                     |   5 +
>>   arch/arm/boot/dts/exynos5.dtsi                     |   5 +
>>   arch/arm/mach-exynos/Kconfig                       |   2 +
>>   arch/arm/mach-exynos/common.h                      |   2 -
>>   arch/arm/mach-exynos/exynos.c                      |  22 ----
>>   arch/arm/mach-exynos/include/mach/map.h            |   8 --
>>   arch/arm/mach-exynos/regs-srom.h                   |  53 --------
>>   arch/arm/mach-exynos/suspend.c                     |  20 +--
>>   arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
>>   drivers/soc/Kconfig                                |   1 +
>>   drivers/soc/Makefile                               |   1 +
>>   drivers/soc/samsung/Kconfig                        |  13 ++
>>   drivers/soc/samsung/Makefile                       |   1 +
>>   drivers/soc/samsung/exynos-srom.c                  | 143 +++++++++++++++++++++
>>   drivers/soc/samsung/exynos-srom.h                  |  51 ++++++++
>>   16 files changed, 236 insertions(+), 104 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
>>   delete mode 100644 arch/arm/mach-exynos/regs-srom.h
>>   create mode 100644 drivers/soc/samsung/Kconfig
>>   create mode 100644 drivers/soc/samsung/Makefile
>>   create mode 100644 drivers/soc/samsung/exynos-srom.c
>>   create mode 100644 drivers/soc/samsung/exynos-srom.h
>>
>
>
