From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 9 Apr 2016 03:25:22 +0900
Subject: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
In-Reply-To: <5707AA47.7090506@fivetechno.de>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <5707AA47.7090506@fivetechno.de>
Message-ID: <CAGTfZH1mzcOfu74Kw1vjJQggU1mKG7=re2Eaqdun3gCxhPq2dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Fri, Apr 8, 2016 at 9:55 PM, Markus Reichl <m.reichl@fivetechno.de> wrote:
> Hi Chanwoo,
>
> I tested both sets on odroid XU4 and U3.
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Thanks for your test always.

Best Regards,
Chanwoo Choi

>
> Am 08.04.2016 um 07:00 schrieb Chanwoo Choi:
>> This patchset support the AMBA bus frequency scaling on Exynos5422-based
>> Odroid-XU3 board. But, this series only support the bus frequency scaling
>> for INT (Internal) block using VDD_INT power line.
>>
>> Also, to support the bus frequency scaling for Exynos542x SoC,
>> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
>> to measure the transfered data traffic on NoC (Network on Chip)
>> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
>> provide the utilization for INT block of Exynos542x SoC.
>>
>> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
>> device (drivers/devfreq/event/exynos-nocp.c) without any modification.
>> Just add the phandle of 'NoC Probe' dt node to bus dt node.
>>
>> Depend on:
>> This patchset depends on patch[1] which support the generic exynos-bus
>> frequency driver.
>>
>> [1] https://lkml.org/lkml/2016/4/8/14
>> - [PATCH v8 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor
>>
>> Chanwoo Choi (7):
>>   PM / devfreq: event: Add new Exynos NoC probe driver
>>   PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
>>   ARM: dts: Add NoC Probe dt node for Exynos542x SoC
>>   dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
>>   clk: samsung: exynos542x: Add the clock id for ACLK
>>   ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
>>   ARM: dts: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3
>>
>>  .../bindings/devfreq/event/exynos-nocp.txt         |  86 +++++
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  19 +
>>  arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 +++++
>>  drivers/clk/samsung/clk-exynos5420.c               |  85 +++--
>>  drivers/devfreq/event/Kconfig                      |   8 +
>>  drivers/devfreq/event/Makefile                     |   2 +
>>  drivers/devfreq/event/exynos-nocp.c                | 247 +++++++++++++
>>  drivers/devfreq/event/exynos-nocp.h                |  78 ++++
>>  include/dt-bindings/clock/exynos5420.h             |  24 +-
>>  10 files changed, 1024 insertions(+), 31 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
>>  create mode 100644 drivers/devfreq/event/exynos-nocp.c
>>  create mode 100644 drivers/devfreq/event/exynos-nocp.h
>>
>
> Thanks,
> --
> Markus Reichl
>
