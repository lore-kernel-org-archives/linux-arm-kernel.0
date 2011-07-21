From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 21 Jul 2011 23:50:20 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <1311230846-26437-1-git-send-email-b32955@freescale.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
Message-ID: <20110721215020.GA25344@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
...
> To Walfram & Artem:
>     About how to disable the JFFS2 to use the OOB:
>     I read the code, and I still have no idea about how to use the ecclayout
>     to do the job. Could you give me some hint? thanks.

Have you checked mxc_nand.c for example? There is

static struct nand_ecclayout nandv1_hw_eccoob_smallpage = {
        .eccbytes = 5,
        .eccpos = {6, 7, 8, 9, 10},
        .oobfree = {{0, 5}, {12, 4}, }
}

defined as one layout. Now, you could define one where oobfree is empty and
eccbytes as big as the oob-area.

> The driver depends on another GPMI-NAND device patch set, you can find them at :
> 	[1] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037033.html
> 	[2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037031.html
> 	[3] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037032.html
> 	[4] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037034.html
> 
> The driver also depends on another DMA patch by Shawn:
> 	[0] http://lists.infradead.org/pipermail/linux-mtd/2011-June/036820.html

This makes it difficult for testers/reviewers. Please try to get a git-branch
from Freescale or Linaro.

> 	[4] DMA timeout issue. I use the .config created by `make mxs_defconfig`
> 	    and the bug never occur. It seems some other module has impact to the
> 	    DMA.

Sadly, I can't confirm that. DMA timeout happens with my config as well as with
the mxs_defconfig. ubiformat breaks immediately when trying to write.

Problem is that I am away from my dev-machine for a few days. I can do limited
tests remotely but not develop actively right now. But if you need logs...

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110721/77ffac8f/attachment-0001.sig>
