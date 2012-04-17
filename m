From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 16:32:10 +0100
Subject: [PATCH 10/16] drivers/gpio: represent gpio-nomadik as an IRQ
 controller in DT documentation
In-Reply-To: <201204171438.33051.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-11-git-send-email-lee.jones@linaro.org>
 <201204171438.33051.arnd@arndb.de>
Message-ID: <4F8D8CFA.5020008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/12 15:38, Arnd Bergmann wrote:
> On Tuesday 17 April 2012, Lee Jones wrote:
>> --- a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
>> @@ -13,6 +13,7 @@ Required properties:
>>                                     4 = active high level-sensitive.
>>                                     8 = active low level-sensitive.
>>   - gpio-controller       : Marks the device node as a GPIO controller.
>> +- gpio-interrupt        : Marks the device node as a GPIO controller.
>>   - gpio-bank             : Specifies which bank a controller owns.
>>   - st,supports-sleepmode : Specifies whether controller can sleep or not
>>
>> @@ -24,6 +25,7 @@ Example:
>>                           interrupts =<0 120 0x4>;
>>                           #gpio-cells =<2>;
>>                           gpio-controller;
>> +                        interrupt-controller;
>>                           supports-sleepmode;
>>                           gpio-bank =<1>;
>>                   };
>
> Documentation doesn't match the example or the code: it should be
> 'interrupt-controller' above, not 'gpio-interrupt'.

Yes, this is actually wrong is a number of ways. I believe this was an 
early adaptation, which I was in the middle of editing. I don't know how 
I ended up committing it. I'll fix and resend.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
