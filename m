From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 13 Jun 2016 21:48:34 +0300
Subject: [PATCH 0/7] ir-rx51 driver fixes
In-Reply-To: <201606132017.38629@pali>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201606132017.38629@pali>
Message-ID: <575F0002.4060809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13.06.2016 21:17, Pali Roh?r wrote:
> On Saturday 07 May 2016 17:21:41 Ivaylo Dimitrov wrote:
>> ir-rx51 is a driver for Nokia N900 IR transmitter. The current series
>> fixes the remaining problems in the driver:
>>
>>   - replace GP timer 9 with PWM framework usage
>>   - replace pulse width timer dmtimer usage with hrtimer
>>   - add DT support to the driver
>>   - add driver to the board DTS
>>
>> Pathes 2 and 5 are needed so the driver to function correctly,
>> without those PWM either refuses to set the needed carrier frequency
>> (patch 2) or there are such a delays in the PWM framework, code that
>> transmission duration raises to ~5s instead of half a second.
>>
>> Ivaylo Dimitrov (6):
>>    pwm: omap-dmtimer: Allow for setting dmtimer clock source
>>    [media] ir-rx51: use PWM framework instead of OMAP dmtimer
>>    [media] ir-rx51: add DT support to driver
>>    ARM: OMAP: dmtimer: Do not call PM runtime functions when not
>> needed. [media] ir-rx51: use hrtimer instead of dmtimer
>>    ARM: dts: n900: enable lirc-rx51 driver
>>
>> Tony Lindgren (1):
>>    ir-rx51: Fix build after multiarch changes broke it
>>
>>   .../devicetree/bindings/media/nokia,lirc-rx51      |  19 ++
>>   .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   4 +
>>   arch/arm/boot/dts/omap3-n900.dts                   |  12 ++
>>   arch/arm/mach-omap2/board-rx51-peripherals.c       |   5 -
>>   arch/arm/mach-omap2/pdata-quirks.c                 |  10 +-
>>   arch/arm/plat-omap/dmtimer.c                       |   9 +-
>>   arch/arm/plat-omap/include/plat/dmtimer.h          |   1 +
>>   drivers/media/rc/Kconfig                           |   2 +-
>>   drivers/media/rc/ir-rx51.c                         | 229
>> +++++++-------------- drivers/pwm/pwm-omap-dmtimer.c
>>      |  12 +- include/linux/platform_data/media/ir-rx51.h        |
>> 3 -
>>   11 files changed, 131 insertions(+), 175 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/media/nokia,lirc-rx51
>
> Patch series looks good, you can add my Acked-by.
>

There is a newer series, please look at https://lkml.org/lkml/2016/5/16/429

Ivo
