From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 25 Feb 2011 14:43:05 +0200
Subject: [PATCH] mtd: nand: fix one typo in the comments
In-Reply-To: <1298610378-3105-1-git-send-email-r64343@freescale.com>
References: <1298610378-3105-1-git-send-email-r64343@freescale.com>
Message-ID: <1298637785.2798.106.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-25 at 13:06 +0800, Jason Liu wrote:
> In the function nand_do_write_oob, the comments
> has one typo, this patch fix it.
> 
> - /* Do not allow reads past end of device */
> + /* Do not allow write past end of device */
> if (unlikely(to >= mtd->size ||
> 	     ops->ooboffs + ops->ooblen >
> 		((mtd->size >> chip->page_shift) -
> 		 (to >> chip->page_shift)) * len)) {
> 	DEBUG(MTD_DEBUG_LEVEL0, "%s: Attempt write beyond "
> 			"end of device\n", __func__);
> 	return -EINVAL;
> }
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>

Oh, please, do not copy the patch into the commit message! It is enough
to say that you fix a typo in a commentary.

But I've amended the commit message and pushed the patch to my
l2-mtd-2.6.git tree, thanks!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
