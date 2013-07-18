From: zonque@gmail.com (Daniel Mack)
Date: Thu, 18 Jul 2013 14:02:24 +0200
Subject: [PATCH] ARM: omap2: fix musb usage for n8x0
In-Reply-To: <51E7B81A.70103@denx.de>
References: <1374000777-5626-1-git-send-email-zonque@gmail.com>
 <51E7B1FF.6000301@denx.de> <51E7B2FA.7020206@ti.com> <51E7B81A.70103@denx.de>
Message-ID: <51E7D950.60900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.07.2013 11:40, Stefan Roese wrote:
> On 07/18/2013 11:18 AM, Kishon Vijay Abraham I wrote:
>>> I'm testing musb as OTG on beagleboard (old one, not Beagle-xm). And
>>> using the latest kernel.org version with this patch applied I see the
>>> following messages while booting (repeatedly):
>>>
>>> [    4.998168] usb usb1: bus auto-suspend, wakeup 1
>>> [    5.003112] musb_bus_suspend 2457: trying to suspend as b_idle while active
>>> [    5.010498] usb usb1: bus suspend fail, err -16
>>> [    5.015289] hub 1-0:1.0: hub_resume
>>> [    5.019073] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
>>> [    5.024963] hub 1-0:1.0: hub_suspend
>>> [    5.028778] usb usb1: bus auto-suspend, wakeup 1
>>> ...
>>>
>>> This is without a cable connected to the OTG port.
>>>
>>> Any ideas what might be missing here?
>>
>> Even I observed these prints when I have dual mode enabled. When kept as gadget
>> only mode I dint see these prints.
> 
> Yes. With gadget-only I don't see those messages. Thanks for the hint.

So in which mode does your port operate then? Gadget or dual-role? And I
take it this does not happen with 3.10?

Unfortunately, I have no board here anymore with such a port in
dual-role mode ...


Daniel
