From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Apr 2014 18:19:48 +0900
Subject: [PATCHv2 8/8] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <534CF847.5040008@arm.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-9-git-send-email-cw00.choi@samsung.com>
 <534CEAB7.6020600@arm.com> <534CED76.9010302@samsung.com>
 <534CF847.5040008@arm.com>
Message-ID: <534CF9B4.306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 06:13 PM, Marc Zyngier wrote:
> On 15/04/14 09:27, Chanwoo Choi wrote:
>> Hi,
>>
>> On 04/15/2014 05:15 PM, Marc Zyngier wrote:
>>> On 15/04/14 02:59, Chanwoo Choi wrote:
>>>> From: Tomasz Figa <t.figa@samsung.com>
>>>>
>>>> This patch add new exynos3250.dtsi to support Exynos3250 SoC based on Cortex-A7
>>>> dual core and includes following dt nodes:
>>>>
>>>> - GIC interrupt controller
>>>> - Pinctrl to control GPIOs
>>>> - Clock controller
>>>> - CPU information (Cortex-A7 dual core)
>>>> - UART to support serial port
>>>> - MCT (Multi Core Timer)
>>>> - ADC (Analog Digital Converter)
>>>> - I2C/SPI bus
>>>> - Power domain
>>>> - PMU (Performance Monitoring Unit)
>>>> - MSHC (Mobile Storage Host Controller)
>>>> - PWM (Pluse Width Modulation)
>>>> - AMBA bus
>>>
>>> [...]
>>>
>>> Where is the arch timer node?
>>
>> Exynos3250 uses MCT (Multi Core Timer) instead of ARM_ARCH_TIMER.
>> - in drivers/clocksource/exynos_mct.c
> 
> Don't you have a Cortex-A7? If so, you have the arch timer.

Do you means that 'arch timer" is ARM_ARCH_TIMER?

As I knew, ARM_ARCH_TIMER is clocksource driver for system timer.
But, Exynos SoC used MCT clocksource for system timer.

Exynos dts file didn't include arch timer node but only include mct node.

Best Regards,
Chanwoo Choi
