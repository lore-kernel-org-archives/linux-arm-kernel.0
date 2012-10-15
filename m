From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 15 Oct 2012 16:48:58 +0300
Subject: [PATCH] MTD: atmel_nand: fix compile error when use
 avr32-atstk1006_defconfig
In-Reply-To: <1349678809-12092-1-git-send-email-josh.wu@atmel.com>
References: <1349678809-12092-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1350308938.5769.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-08 at 14:46 +0800, Josh Wu wrote:
> fixed the following compile error when use avr32 config:
> drivers/mtd/nand/atmel_nand.c: In function 'pmecc_err_location':
> drivers/mtd/nand/atmel_nand.c:639: error: implicit declaration of function 'writel_relaxed'
> 
> Since in ARCH avr32, there is no macro "writel_relaxed" defined. In this patch we use macro "writel" instead.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Why not to provide writel_relaxed() in AVR instead?

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/803e0b10/attachment.sig>
