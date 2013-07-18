From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 18 Jul 2013 14:48:50 +0530
Subject: [PATCH] ARM: omap2: fix musb usage for n8x0
In-Reply-To: <51E7B1FF.6000301@denx.de>
References: <1374000777-5626-1-git-send-email-zonque@gmail.com>
 <51E7B1FF.6000301@denx.de>
Message-ID: <51E7B2FA.7020206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 18 July 2013 02:44 PM, Stefan Roese wrote:
> On 07/16/2013 08:52 PM, Daniel Mack wrote:
>> Commit b7e2e75a8c ("usb: gadget: drop unused USB_GADGET_MUSB_HDRC")
>> dropped a config symbol that was unused by the musb core, but it turns
>> out that board support code had references to it.
>>
>> As the core now has a fall-back to host-only mode if support for
>> dual-role is not compiled in, so we can just pass MUSB_OTG as
>> mode from board files.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Reported-and-tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> I'm testing musb as OTG on beagleboard (old one, not Beagle-xm). And
> using the latest kernel.org version with this patch applied I see the
> following messages while booting (repeatedly):
> 
> [    4.998168] usb usb1: bus auto-suspend, wakeup 1
> [    5.003112] musb_bus_suspend 2457: trying to suspend as b_idle while active
> [    5.010498] usb usb1: bus suspend fail, err -16
> [    5.015289] hub 1-0:1.0: hub_resume
> [    5.019073] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [    5.024963] hub 1-0:1.0: hub_suspend
> [    5.028778] usb usb1: bus auto-suspend, wakeup 1
> ...
> 
> This is without a cable connected to the OTG port.
> 
> Any ideas what might be missing here?

Even I observed these prints when I have dual mode enabled. When kept as gadget
only mode I dint see these prints.
However if you connect a cable, you should still see that enumeration should
succeed.
Not sure why those prints come though :-s

Thanks
Kishon
