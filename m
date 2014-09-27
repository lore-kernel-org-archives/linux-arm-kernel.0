From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 27 Sep 2014 10:33:37 +0200
Subject: [PATCH] bcma: use device from DT (brcm,bus-gpio) for SoC GPIO chip
In-Reply-To: <CACna6rwwfJOdnxhmnW7MUuUC1YBPx8bmDbiaSy1+G39hF4p7OA@mail.gmail.com>
References: <1411741733-13888-1-git-send-email-zajec5@gmail.com>	<2539898.4te2VKk57a@wuerfel>
 <CACna6rwwfJOdnxhmnW7MUuUC1YBPx8bmDbiaSy1+G39hF4p7OA@mail.gmail.com>
Message-ID: <54267661.5000401@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2014 10:05 AM, Rafa? Mi?ecki wrote:
> On 27 September 2014 00:03, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 26 September 2014 16:28:53 Rafa? Mi?ecki wrote:
>>> +The top-level axi bus may contain following children:
>>> +
>>> +- gpio: GPIO chip on the SoC
>>> +
>>> +  Required properties:
>>> +  - compatible: "brcm,bus-gpio"
>>> +  - gpio-controller : makes the node a GPIO controller
>>> +  - #gpio-cells : size of the GPIO specifier, must be 2
>>> +
>>>
>>
>> I wonder if it would be better to avoid the subnode here and just
>> make the parent itself the gpio controller.
>>
>> Is the gpio controller part of the bus itself in reality, or is it
>> a device that gets probed on the bus?
> 
> I'm not sure how to treat this chip.
> We control GPIOs using ChipCommon regs (and ChipCommon is one of
> cores/devices on the bus), so you could also consider GPIO chip a
> sub-device of ChipCommon.
> I believe every Broadcom bus has a GPIO chip. In the ancient (MIPS)
> times, even if we didn't have ChipCommon, there was an EXTIF core that
> used to provide access to the GPIO chip.
> 
> What do you think? Should I make it separated device, even it if
> depends on the SoC and its ChipCommon core (device)?
> 
I would make GPIO a subdevive of chipcommon. The chipcommon core has an
own IRQ which is also used for GPIO.

Hauke
