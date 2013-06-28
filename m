From: B29397@freescale.com (Chen Peter-B29397)
Date: Fri, 28 Jun 2013 06:48:30 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201306271549.01136.marex@denx.de>
References: <51A5A808.2070803@digi.com> <201306241551.19831.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306271549.01136.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803EFF1F2@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> - I use the port in HOST mode by plugging in a USB pendrive over the OTG-
> capable
> reduction ; this works OK
> - I disconnect the reduction and connect it to the computer ; here I get
> "timeout waiting for 00000800 in 11".
> 
> This means the BSV bit in OTGSC register wasn't unset.
> 
> Interestingly enough, transition the other way around (first use in
> gadget mode
> then in host mode) works fine, but if I do host mode -> gadget mode, I
> get the
> timeout. Do you have any hint for me?
> 

It means your OTG VBUS does not lower than BSV (B SESSION VALID, 0.8v) after
plugging out Micro-B-TO-A cable. Two possible reasons:

1. You have not gpio control for vbus toggle when role switches.
2. Your hardware has some problems that the vbus can't lower than 0.8v.

> btw. what is the plan about cleaning up and upstreaming all these patches
> we
> have here? Is anyone working on it? I'd hate to stomp on anyones'
> efforts,but
> I'd also like to see this mess sorted out.

We had something un-decided before, now, things almost are cleared.
But I am a little busy recently, I hope I can begin to work on it
from next week.

Best regards,
Peter
 
