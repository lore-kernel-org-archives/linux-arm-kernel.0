From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 25 May 2012 19:55:07 +0300
Subject: [PATCH 2/2] mtd mxc_nand: move ecc strengh setup before
 nand_scan_tail
In-Reply-To: <1337955762-19157-2-git-send-email-s.hauer@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <1337955762-19157-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337964907.30969.57.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-25 at 16:22 +0200, Sascha Hauer wrote:
> Since this commit:
> 
>   commit 6a918bade9dab40aaef80559bd1169c69e8d69cb
>   Author: Mike Dunn <mikedunn@newsguy.com>
>   Date:   Sun Mar 11 14:21:11 2012 -0700
> 
>      mtd: flash drivers set ecc strength
> 
> The mxc_nand driver fails with:
> 
> Driver must set ecc.strength when using hardware ECC
> 
> This is because nand_scan_tail checks for correct ecc strength
> settings, so we must set them up before nand_scan_tail.

Pushed this one to l2-mtd.git as well, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/5227da8b/attachment-0001.sig>
