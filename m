From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 17 Sep 2015 08:13:37 +0900
Subject: [PATCH] ARM: dts: Fix LEDs on exynos5422-odroidxu3
In-Reply-To: <55F9F6A6.6080206@kernel.org>
References: <1441205288-22047-1-git-send-email-k.kozlowski.k@gmail.com>
 <55F9F6A6.6080206@kernel.org>
Message-ID: <55F9F7A1.9050709@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/15 08:09, Kukjin Kim wrote:
> On 09/02/15 23:48, Krzysztof Kozlowski wrote:
>> The LEDs on Odroid XU3 family boards could not properly probe because PWM
>> outputs were reduced only to PWM for fan. Fix this to:
>>  - Odroid XU3 and XU3-Lite: 4 outputs (although the PWM for MIPI
>>    probably is redundant because board does not have MIPI connector
>>    available);
>>  - Odroid XU4: 2 outputs.
>>
>> This fixes warnings on dmesg:
>> [    4.838712] samsung-pwm 12dd0000.pwm: tried to request PWM channel 1 without output
>> [    4.838725] leds_pwm pwmleds: unable to request PWM for green:mmc0: -22
>> [    4.838767] leds_pwm: probe of pwmleds failed with error -22
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>
>> ---
>>
>> Patch depends/is rebased on latest DTS for Odroid XU4 board:
>>  - http://www.spinics.net/lists/arm-kernel/msg442474.html
>>  - http://www.spinics.net/lists/arm-kernel/msg442475.html
>> ---
> 
> Applied, thanks.
> 
Oops, I mean already this change is included in your another patch.

- Kukjin
