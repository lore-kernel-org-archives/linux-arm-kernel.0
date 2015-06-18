From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Thu, 18 Jun 2015 18:23:34 +0200
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <5582C87C.20008@tronnes.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org> <5582C87C.20008@tronnes.org>
Message-ID: <5582F086.30301@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 18.06.2015 15:32, skrev Noralf Tr?nnes:
>
> Den 18.06.2015 04:26, skrev Stephen Warren:
>> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>>> Add a duplicate irq range with an offset on the hwirq's so the
>>> driver can detect that enable_fiq() is used.
>>> Tested with downstream dwc_otg USB controller driver.
>> This basically looks OK, but a few comments/thoughts:
>>

>> c) The DT binding needs updating to describe the extra IRQs:
>>
>>> Documentation/devicetree/bindings/interrupt-controller/brcm,bcm28armctrl-ic.txt 
>>>
>
> Ok.
>

I have seconds thoughts on this:
This patch does not change the DT bindings so I don't see what update
I should make. This patch only adds support for the Linux way of
handling FIQ's through enable_fiq(). It doesn't change how interrupts
are described in the DT.
