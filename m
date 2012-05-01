From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 1 May 2012 03:13:21 +0000
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1335837363-12376-1-git-send-email-marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7C3E3@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
 
> V7: * Pass only necessary data to the drivers registered by imx-otg
>       (memory, irq, pointer to imx-otg device). This should fix issue
> pointed
>       out by Lothar Wassmann.
>     * Have single IRQ handler in imx-otg, which then calls host/gadget
> IRQ
>       handlers only if they're registered via imx_otg_set_irq_handler()
> call,
>       depending on the current state of the OTG.
> 
 
Hi Marek,

If the host and device interrupt handler are called by otg interrupt handler,
then, the interrupt handlers are registered by host/device will be called twice
as they are also registered by host/device themselves.

Besides, what kinds of function do you want to add at this patchset?
device-only?host-only? basic otg (id switch)? power management (As I have seen you add
wakeup interrupt handler)?
 
