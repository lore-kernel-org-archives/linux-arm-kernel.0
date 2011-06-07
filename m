From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 07 Jun 2011 14:17:47 +0300
Subject: [PATCH 2/2] MTD: pxa3xx_nand: Fix blank page ECC mismatch
In-Reply-To: <1307440867-18993-2-git-send-email-leiwen@marvell.com>
References: <1307440867-18993-1-git-send-email-leiwen@marvell.com>
	<1307440867-18993-2-git-send-email-leiwen@marvell.com>
Message-ID: <1307445467.11104.80.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-07 at 03:01 -0700, Lei Wen wrote:
> From: Daniel Mack <zonque@gmail.com>
> 
> This bug was introduced in f8155a40 ("mtd: pxa3xx_nand: rework irq
> logic") and causes the PXA3xx NAND controller fail to operate with NAND
> flash that has empty pages. According to the comment in this block, the
> hardware controller will report a double-bit error for empty pages,
> which can and must be ignored.
> 
> This patch restores the original behaviour of the driver.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Acked-by: Lei Wen <leiwen@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> Cc: stable at kernel.org

This was introduced in 2.6.38, so let's make it:

Cc: stable at kernel.org [2.6.38+]

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
