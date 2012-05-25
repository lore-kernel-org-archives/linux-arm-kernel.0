From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 25 May 2012 09:29:24 -0700
Subject: [PATCH 2/2] mtd mxc_nand: move ecc strengh setup before
 nand_scan_tail
In-Reply-To: <1337955762-19157-2-git-send-email-s.hauer@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <1337955762-19157-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4FBFB364.70601@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2012 07:22 AM, Sascha Hauer wrote:
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


Oops, sorry Sascha.  This was compile-tested only, but I should have ensured
strength was set before call to nand_scan_tail().

Thanks,
Mike
