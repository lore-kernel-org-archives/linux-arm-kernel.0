From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 04 Sep 2015 15:48:46 +0900
Subject: [PATCHv7] ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
In-Reply-To: <CANAwSgQOijKEyhvM=DU4nRdGK6v5cxJUZ54pnnG2YqjeT9pBxA@mail.gmail.com>
References: <1441303910-3266-1-git-send-email-linux.amoon@gmail.com>
 <55E8DDDD.80106@samsung.com> <55E8E534.1040204@osg.samsung.com>
 <CANAwSgQOijKEyhvM=DU4nRdGK6v5cxJUZ54pnnG2YqjeT9pBxA@mail.gmail.com>
Message-ID: <55E93ECE.60006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.09.2015 15:20, Anand Moon wrote:
> Hi All,
> 
> On 4 September 2015 at 05:56, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Krzysztof,
>>
>> On 09/04/2015 01:55 AM, Krzysztof Kozlowski wrote:
>>> On 04.09.2015 03:11, Anand Moon wrote:
>>>> Earlier design of the LED for Odroid XU3 was using gpio-leds
>>>> Now It was change to using both pwm-leds and gpio-leds.
>>>
>>> It is still not a reason for this change. gpio-leds were not enabled
>>> before. This could be a valid reason of adding LEDS_PWM to existing
>>> config LEDS_GPIO. But LEDS_GPIO were not enabled... so why the change on
>>> the board from gpio->(gpio+pwm) means that we have to enable LEDS_GPIO?
>>>
>>
>> Agreed, also the commit message doesn't explain why the heartbeat
>> LED trigger is enabled as I mentioned in the previous version.
>>
>>> Actually I gave up on this and I wanted to change the commit message on
>>> myself when applying. But discussion was brought up again so... clearly
>>> we have different understanding of the meaning of "WHY". :)
>>>
>>> Best regards,
>>> Krzysztof
>>>
> 
> Just of the records. I you agree with following commit message I will
> resend the patch.
> ------------------------------------------------------
> Exynos boards support GPIO and PWM based LEDs
> 
> Odroid boards support led activity to indicate the various status
> Red led - power: hooked up to 5V power
> Blue led - alive Solid light : u-boot is running
>                flashing : Kernel is running (heart beat)
> -------------------------------------------------------
> If you want to add some thing more please suggest me.
> 
> Earlier I was just frustrated.

That commit message looks better. Anyway I applied the patch with
changed message. You can find it here:
https://github.com/krzk/linux/commit/8b14e57ae423b676873e542944ed8714be211ded

although it is not pushed to the for-next branch because we are at merge
window.

Best regards,
Krzysztof
