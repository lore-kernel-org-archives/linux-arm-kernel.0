From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 16 Feb 2015 13:08:35 +0100
Subject: [PATCH 03/14] clocksource: Add ARM System timer driver
In-Reply-To: <CAL_JsqKoT_rWzt6ZCQXwg-NxM_Mnuqy6UwmPKBRodBCf0i7zyg@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-4-git-send-email-mcoquelin.stm32@gmail.com>
 <CAL_JsqKoT_rWzt6ZCQXwg-NxM_Mnuqy6UwmPKBRodBCf0i7zyg@mail.gmail.com>
Message-ID: <CALszF6Ado887mceaYV1y0054qKGPHrJ+fiC82bx+SQVUV_eybw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-15 23:31 GMT+01:00 Rob Herring <robherring2@gmail.com>:
> On Thu, Feb 12, 2015 at 11:45 AM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> This patch adds clocksource support for ARMv7-M's System timer,
>> also known as SysTick.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/system_timer.txt       | 15 +++++
>
> Please include v7M in the name. System timer sounds very generic. This
> is the only timer architecturally defined IIRC, so perhaps just
> "armv7m_systick".

Ok, let's go for "armv7m_systick".

>
>>  drivers/clocksource/Kconfig                        |  7 ++
>>  drivers/clocksource/Makefile                       |  1 +
>>  drivers/clocksource/arm_system_timer.c             | 74 ++++++++++++++++++++++
>
> Same here.

Agree, will be in the v2.

>
>
>>  4 files changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/system_timer.txt
>>  create mode 100644 drivers/clocksource/arm_system_timer.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/system_timer.txt b/Documentation/devicetree/bindings/arm/system_timer.txt
>> new file mode 100644
>> index 0000000..35268b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/system_timer.txt
>> @@ -0,0 +1,15 @@
>> +* ARM System Timer
>> +
>> +ARMv7-M includes a system timer, known as SysTick. Current driver only
>> +implements the clocksource feature.
>> +
>> +Required properties:
>> +- compatible : Should be "arm,armv7m-systick"
>> +- reg       : The address range of the timer
>> +- clocks     : The input clock of the timer
>
> You may want to consider supporting "clock-frequency" here too. In
> more simple chips you may just have fixed clocks and may want to run a
> kernel with COMMON_CLK disabled for size savings.

Ok, I will add this option in the v2.

>
>> +
>> +systick: system-timer {
>
> This should be "systick: timer at e000e010".
>
> Same for your dts file.

Right, it will be fixed in the v2.

Thanks for the review,
Maxime
