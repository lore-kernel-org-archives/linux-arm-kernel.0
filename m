From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 May 2014 22:46:34 +0900
Subject: [PATCH v3 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <536C5E40.90405@gmail.com>
References: <1399522592-23618-1-git-send-email-sachin.kamat@linaro.org>
 <536BAE39.70504@samsung.com> <034b01cf6b2c$5b5d06b0$12171410$@samsung.com>
 <536C5E40.90405@gmail.com>
Message-ID: <536CDC3A.4050700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/14 13:49, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi Tomasz,

> On 09.05.2014 04:14, Kukjin Kim wrote:
>> Tomasz Figa wrote:
>>>
>>> Hi Sachin,
>>>
>>> On 08.05.2014 06:16, Sachin Kamat wrote:
>>>> Instead of hardcoding the SYSRAM details for each SoC,
>>>> pass this information through device tree (DT) and make
>>>> the code SoC agnostic. Generic SRAM bindings are used
>>>> for achieving this.
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>>> ---
>>>> Changes since v2.
>>>> * Updated sysram node for Universal C210 board - Thanks to
>>>> Tomasz Figa for testing and updating the same.
>>>> * Added error handling code.
>>>> * Break if matching node found.
>>>> * Remove unnecessary error messages.
>>>>
>>>> This patch is based on linux next (next-20140501) on top of
>>>> my Kconfig consolidation patch
>>>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/28642
>>>>
>>>> Tested on 4210/4412 Origen, 5250/5420 Arndale and SMDK5420 boards.
>>>> ---
>>>> arch/arm/Kconfig | 1 +
>>>> arch/arm/boot/dts/exynos4210-universal_c210.dts | 15 ++++++
>>>> arch/arm/boot/dts/exynos4210.dtsi | 18 +++++++
>>>> arch/arm/boot/dts/exynos4x12.dtsi | 18 +++++++
>>>> arch/arm/boot/dts/exynos5250.dtsi | 18 +++++++
>>>> arch/arm/boot/dts/exynos5420.dtsi | 18 +++++++
>>>> arch/arm/mach-exynos/common.h | 1 +
>>>> arch/arm/mach-exynos/exynos.c | 64
>> ----------------------
>>> -
>>>> arch/arm/mach-exynos/firmware.c | 8 ++-
>>>> arch/arm/mach-exynos/include/mach/map.h | 7 ---
>>>> arch/arm/mach-exynos/platsmp.c | 56
>> ++++++++++++++++++--
>>>> 11 files changed, 148 insertions(+), 76 deletions(-)
>>>>
>>>
>>> Looks good, thanks.
>>>
>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>>
>> Looks good to me but I think, we need to change the name of 'sram'
>> because
>> it can cause some confusing, actually it is not matching _real_ sram
>> area on
>> the SoCs. When we upstreamed regarding patch, I decided the name to use
>> 'SYSRAM', it was called another name in datasheet though. So, I'd like to
>> use 'sysram' instead of 'sram' as we used before.
>>
>> I will change the name when I apply this series in this weekend, if
>> you guys
>> have no objection.
>
> You mean s/sram/sysram/ in compatible strings of Exynos-specific
> reserved areas? If yes, I'm fine, it might be even better. Just remember
> to update documentation in patch 2/2 as well.
>
Yes, of course ;-)

- Kukjin
