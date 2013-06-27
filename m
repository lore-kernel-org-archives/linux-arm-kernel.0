From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Jun 2013 15:49:00 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306241551.19831.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201306271549.01136.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > No, I don't have this one available right now. I tried both MX23
> > Olinuxino maxi
> > (I just mutilated the board so that I cut traces to the USB devices on
> > the board
> > and routed out USB gadget connector) and a custom MX23 board.
> > 
> > Note that both have working USB peripheral mode in U-Boot too, but the
> > driver in
> > U-Boot is very minimalistic.
> 
> You mean, the larger data transfer with USB peripheral mode is ok at
> u-boot? but it can't work at Linux Kernel?

I stumbled across one more problem with the patches:

- I use OTG on MX28
- I configured the USB ID pin
- I set the dr_mode to "otg"
(so far so good)
- I use the port in HOST mode by plugging in a USB pendrive over the OTG-capable 
reduction ; this works OK
- I disconnect the reduction and connect it to the computer ; here I get 
"timeout waiting for 00000800 in 11".

This means the BSV bit in OTGSC register wasn't unset.

Interestingly enough, transition the other way around (first use in gadget mode 
then in host mode) works fine, but if I do host mode -> gadget mode, I get the 
timeout. Do you have any hint for me?

btw. what is the plan about cleaning up and upstreaming all these patches we 
have here? Is anyone working on it? I'd hate to stomp on anyones' efforts,but 
I'd also like to see this mess sorted out.

Best regards,
Marek Vasut
