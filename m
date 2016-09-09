From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 9 Sep 2016 11:47:28 +0100
Subject: [PATCH 2/2] ARM: dts: add device tree for the RealView EB Rev D
In-Reply-To: <CACRpkdZdY-knG+htdgZ0t80GLqC7aNujNf7mwUveDrAnCQ5yfQ@mail.gmail.com>
References: <1473327043-31903-1-git-send-email-linus.walleij@linaro.org>
 <15288435.aYlmo6e5Gb@wuerfel>
 <CACRpkdZdY-knG+htdgZ0t80GLqC7aNujNf7mwUveDrAnCQ5yfQ@mail.gmail.com>
Message-ID: <e396557c-774a-fbc7-b1d7-04d49b0287b8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 08/09/16 11:00, Linus Walleij wrote:
> On Thu, Sep 8, 2016 at 11:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday, September 8, 2016 11:30:43 AM CEST Linus Walleij wrote:
>>> @@ -608,6 +608,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
>>>         arm-realview-pb1176.dtb \
>>>         arm-realview-pb11mp.dtb \
>>>         arm-realview-eb.dtb \
>>> +       arm-realview-eb-revd.dtb \
>>>         arm-realview-eb-11mp.dtb \
>>>         arm-realview-eb-11mp-revb.dtb \
>>>         arm-realview-eb-a9mp.dtb \
>>
>> Is the ethernet device on the baseboard or the core tile?
> 
> It's on the baseboard.
> 
>> My understanding is that you have a baseboard which comes in
>> different revisions and a set of CPU modules (arm9, arm1136,
>> arm1176, arm11mp, cortex-a9, ...) that can be freely combined,
>> so if the ethernet device is on the baseboard, we also need revd
>> variants for 11mp and a9mp.
> 
> Yeah... you're right.
> 
>> The arm-realview-eb-11mp-revb seems to refer to RevB of
>> the core tile rather than the baseboard (?), so we may need
>> a better notation for the file names to clarify that difference.
> 
> OK will try to come up with some namespace.
> 
> Revisiting this mess...

FWIW, a quick survey of our cupboard reveals a roughly equal number of
rev D baseboards vs. rev C - I have no idea about the distribution out
in the wild, but I'd be inclined to suspect it's more of an oversight in
updating the documentation than rev D being particularly "special".

I wonder if it would be feasible to simply add a disabled LAN91C111 next
to the LAN9118 and have a hook in realview-dt.c to swizzle the status at
runtime based on a read of SYS_ID? (Or is that utterly disgusting?)

Robin.

> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
