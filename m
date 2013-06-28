From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Jun 2013 11:42:51 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFF1F2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306271549.01136.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF1F2@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201306281142.51676.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > - I use the port in HOST mode by plugging in a USB pendrive over the OTG-
> > capable
> > reduction ; this works OK
> > - I disconnect the reduction and connect it to the computer ; here I get
> > "timeout waiting for 00000800 in 11".
> > 
> > This means the BSV bit in OTGSC register wasn't unset.
> > 
> > Interestingly enough, transition the other way around (first use in
> > gadget mode
> > then in host mode) works fine, but if I do host mode -> gadget mode, I
> > get the
> > timeout. Do you have any hint for me?
> 
> It means your OTG VBUS does not lower than BSV (B SESSION VALID, 0.8v)
> after plugging out Micro-B-TO-A cable.

Where can I measure this?

> Two possible reasons:
> 
> 1. You have not gpio control for vbus toggle when role switches.

This works well.

> 2. Your hardware has some problems that the vbus can't lower than 0.8v.

How can I check that?

> > btw. what is the plan about cleaning up and upstreaming all these patches
> > we
> > have here? Is anyone working on it? I'd hate to stomp on anyones'
> > efforts,but
> > I'd also like to see this mess sorted out.
> 
> We had something un-decided before, now, things almost are cleared.
> But I am a little busy recently, I hope I can begin to work on it
> from next week.

Ok then, I won't interfere.

Best regards,
Marek Vasut
