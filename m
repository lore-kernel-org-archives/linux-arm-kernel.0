From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Jan 2012 11:44:28 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <4F2671C3.6000809@freescale.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130094610.GA15596@pengutronix.de>
 <4F2671C3.6000809@freescale.com>
Message-ID: <20120130104428.GB15596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The bootloader usually is burned on /dev/mtd0, while the BBT is placed
> at the end
> of the NAND chip.
> 
> I tested the NAND boot mode too.
> 
> What's your concern?

Bootloaders may also need to write to NAND. So, they need to share the
same bad block information with the kernel. Currently, I am not aware of
a bootloader for mxs which support BBT without OOB. Unless this has
changed meanwhile, we shouldn't make this default, because they can't
share the same information then. To be on the safe side regardings
regressions, we shouldn't make this default as well, come to think of
it.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120130/6d726d4e/attachment.sig>
