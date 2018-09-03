From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 3 Sep 2018 11:31:48 -0700
Subject: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
In-Reply-To: <829194253.51526.1535908415057@email.1und1.de>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
 <829194253.51526.1535908415057@email.1und1.de>
Message-ID: <642d46f3-7c1d-2b97-5d49-8772c75be530@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/2/2018 10:13 AM, Stefan Wahren wrote:
> Hi Guenter,
> 
>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49 geschrieben:
>>
>>
>> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
>>> Hi Guenter,
>>>
>>>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
>>>>
>>>>
>>>> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
>>>>> This series is an early stage of the hwmon driver for the fan on the
>>>>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
>>>>> Device Tree Overlay.
>>>>>
>>>>> Changes by Stefan based on [2]:
>>>>> - reformat the downstream patches for submission
>>>>> - drop reboot notification
>>>>> - fix remaining checkpatch issues
>>>>> - add COMPILE_TEST to Kconfig
>>>>>
>>>>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
>>>>> i see two options:
>>>>>
>>>>> 1) integrate the driver function into the pwm-fan driver (new compatible)
>>>>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
>>>>>
>>>>
>>>> I don't really see the point of thise driver. Why not implement either of those ?
>>>
>>> i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
>>>
>>
>> The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
>> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
>> You appear to be arguing that the pwm-fan driver for Rpi is different than
>> a pwm-fan driver for all other hardware and should _not_ use a pwm driver
>> to set pwm values.
> 
> thanks for your explanation. Now i think i understand and sorry for the confusion. We need a driver which translate the pwm values into the mailbox properties. "My" RFC series is only a starting point (not intended for merge and not an option) for a discussion and i'm perfectly fine with 2).
> Both options would be feasible in general. I only wanted to know your opinion before i start to implement one of them.

Is not there a way to expose the PWM pins directly to the kernel instead 
of going through the firmware to do that for us? I am just asking 
because sometimes this appears to be possible, guess not in this case?
-- 
Florian
