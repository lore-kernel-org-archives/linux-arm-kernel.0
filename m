From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 28 Apr 2012 15:20:54 +0300
Subject: [PATCH 00/10] allow mxc_nand to be probed via device tree
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335615654.1937.20.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-23 at 11:22 +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series aims to be able to probe mxc_nand devices via device tree.
> Most of its patches reorganize the driver to only use cpu_is_mxYZ for
> the case that the device is not probed via device tree.
> 
> I split this conversion in several patches to allow easier review. IMHO
> it makes sense to keep this splitting for an eventual bisection.
> 
> This is tested on an i.MX27 based machine and works fine including
> passing of partition data.

Applied all 11 patches from your git tree to l2-mtd.git. Note, you have
one checkpatch.pl warning:

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#69: FILE: drivers/mtd/nand/mxc_nand.c:274:
+static const char *part_probes[] = { "RedBoot", "cmdlinepart", "ofpart", NULL };

Also there are still several sparse warnings, e.g.

+drivers/mtd/nand/mxc_nand.c:1249:26: warning: incorrect type in initializer (different modifiers) [sparse]
+drivers/mtd/nand/mxc_nand.c:1249:26:    expected void *data [sparse]
+drivers/mtd/nand/mxc_nand.c:1249:26:    got struct mxc_nand_devtype_data static const [toplevel] *<noident> [sparse]

And you added few gcc warnings, e.g.:

+drivers/mtd/nand/mxc_nand.c:1252:3: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

Would you take a look and _possibly_ (if makes sense, I did not verify)
send incremental fixes?

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120428/4f7f8a3e/attachment.sig>
