From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 20 Dec 2010 14:55:35 +0100
Subject: [PATCH v7 05/15] ARM: mxs: Add low-level debug UART support
In-Reply-To: <20101220132147.GB16497@freescale.com>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
	<1292679575-2635-4-git-send-email-shawn.guo@freescale.com>
	<20101220115059.GA8885@pengutronix.de>
	<20101220132147.GB16497@freescale.com>
Message-ID: <20101220135535.GB8885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > We should use asm/hardware/debug-pl01x.S, like the other users:
> 
> Just tested it, and it works.  Will do in v8.  Thanks for the comment.

Cool.

> > 
> > >  arch/arm/mach-mxs/include/mach/uncompress.h  |   76 ++++++++++++++++++++++++++
> > 
> > Auto-detection could be used here, too?
> > 
> I'm afraid not.  How do you expect the detection is done, by reading
> some register like we are doing in system.c?

I am not sure which register you mean in system.c?

> Which register specifically?

The signature of the amba device (base + size - 0x20). You can check
drivers/amba/bus.c how it checks for the signature.

> If the register gets different address between
> mx23 and mx28, we need to utilize the current mechanism to
> distinguish the address anyway.

We could simply test both locations and see where it is present?

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101220/73f23c53/attachment.sig>
