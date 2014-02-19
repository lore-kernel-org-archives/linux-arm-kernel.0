From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Feb 2014 15:51:21 +0100
Subject: [PATCH v4 1/7] Documentation: Add device tree bindings for
 Freescale i.MX GPC
In-Reply-To: <201402191538.08507.arnd@arndb.de>
References: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
 <2328803.HhaG6blXIR@wuerfel>
 <1392802255.3445.18.camel@pizza.hi.pengutronix.de>
 <201402191538.08507.arnd@arndb.de>
Message-ID: <5304C4E9.6090505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19.02.2014 15:38, Arnd Bergmann wrote:
> On Wednesday 19 February 2014, Philipp Zabel wrote:
>
>> Am Dienstag, den 18.02.2014, 19:10 +0100 schrieb Arnd Bergmann:
>>> On Tuesday 18 February 2014 16:34:41 Philipp Zabel wrote:
>>>> +
>>>> +Example of a device that is part of a power domain:
>>>> +
>>>> +       vpu: vpu at 02040000 {
>>>> +               reg = <0x02040000 0x3c000>;
>>>> +               /* ... */
>>>> +               fsl,power-domain = <&pd_pu>;
>>>> +               /* ... */
>>>> +       };
>>>> +
>>>
>>> I'm really not too happy about platforms starting to add random
>>> bindings for power domains. Unfortunately I didn't catch exynos
>>> doing this first, but I don't want to see another platform like
>>> that.
>>>
>>> Can we please come up with a proper generic power domain binding
>>> first and then add platform specific users?
>>
>> what is the process here? I've seen the samsung bindings and copied the
>> pattern. I guess the Exynos bindings are set in stone, and the i.MX
>> power domains can be handled using the same bindings.
>
> * First of all, get the pm domain maintainers into the loop, then make
>    sure all other users of pm domains are aware of what you are doing.
>
> * Come up with a way to describe a pm_domain in a sufficiently generic
>    way. It's possible you just need a phandle, but experience on other
>    subsystems suggests that it helps to allow arguments, as we do for
>    clocks, dmas, mailboxes, etc.
>
> * Draft a generic binding that can work on all platforms
>
> * Implement support for the generic binding in the platform independent
>    code.
>
> * Add a specific binding for your hardware.
>
> * Implement support for your hardware binding on top of the generic
>    code.
>
> * Get everyone involved to Ack the generic binding and implementation.
>
> 	Arnd
>

Just wanted to share a link with you. ;)

http://www.spinics.net/lists/devicetree/msg18051.html

Best regards,
Tomasz
