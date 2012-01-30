From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Jan 2012 12:41:31 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <4F267F21.1030204@freescale.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130094610.GA15596@pengutronix.de>
 <4F2671C3.6000809@freescale.com>
 <20120130104428.GB15596@pengutronix.de>
 <4F267F21.1030204@freescale.com>
Message-ID: <20120130114131.GC15596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCing Marek, he can say more about the U-Boot side probably...

> > Bootloaders may also need to write to NAND. So, they need to share the
> Do you mean the uboot may write something to the NAND?
> Could you show me some more detail cases?

U-Boot has NAND support in mainline, for barebox it is work-in-progress.
Both can and do write to NAND (kernel, rootfs), because both have
established procedures to do so (and maybe don't want to rely on
third-party tools like kobs-ng).

> > share the same information then. To be on the safe side regardings
> The kobs-ng which burns the bootloader to the NAND will also burn the
> whole BBT
> to the NAND too.

Did it always do that? Or is a newer version needed?

> But if the bootloader can make some block bad, the BBT information
> becomes different.
> Does the bootloader have the feature to make some block bad?

Sure. If you are able to write NAND, you should be able to mark blocks
bad, too :)

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120130/99632de8/attachment.sig>
