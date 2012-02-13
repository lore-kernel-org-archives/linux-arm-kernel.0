From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Mon, 13 Feb 2012 16:22:49 +0000
Subject: =?utf-8?B?UmU6IOetlOWkjTogW1BBVENIXSBtdGQvZ3BtaSA6IGFkZCBncG1pIHN1cHBv?=
 =?utf-8?Q?rt_for_mx6q?=
In-Reply-To: <14C4E31473AF7E4B98176CB73615181C362D9F@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>	,
 <1329134454.22240.114.camel@sauron.fi.intel.com>
 <14C4E31473AF7E4B98176CB73615181C362D9F@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <1329150312.22240.211.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-13 at 15:05 +0000, Huang Shijie-B32955 wrote:
> Hi Artem:
> 
> >Please, let me know how I can compile-test this. This diver depends on
> >imx23 or imx28 and I cannot find a defconfig for these. When I select
> >MXS platform the compilation fails. Could you please describe some way
> >to generate a compilable configuration which would include this driver
> >as well, or send me the defconfig file.
> 
> use make mxs_defconfig to make the .config.
> and select the gpmi-nand driver. then you can compile it.
> 
> This patch is just part of the patches for mx6q, another two patches are the mxs-dma patches.
> So in the mx6q, I do not enable the  gpmi-nand driver. you can compile-test it just on mxs_defconfig.

I cannot apply this to l2-mtd.git tree anyway:

$:~/git/l2-mtd$ git am ~/tmp/gpmi.mbox
Applying: mtd/gpmi : add gpmi support for mx6q
error: patch failed: drivers/mtd/nand/gpmi-nand/gpmi-lib.c:1066
error: drivers/mtd/nand/gpmi-nand/gpmi-lib.c: patch does not apply
Patch failed at 0001 mtd/gpmi : add gpmi support for mx6q
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
$:~/git/l2-mtd$ patch -p1 < .git/rebase-apply/patch 
patching file drivers/mtd/nand/gpmi-nand/bch-regs.h
patching file drivers/mtd/nand/gpmi-nand/gpmi-lib.c
Hunk #3 FAILED@1067.
1 out of 3 hunks FAILED -- saving rejects to file drivers/mtd/nand/gpmi-nand/gpmi-lib.c.rej
patching file drivers/mtd/nand/gpmi-nand/gpmi-nand.c
patching file drivers/mtd/nand/gpmi-nand/gpmi-nand.h


-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/893c4050/attachment.sig>
-------------- next part --------------
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
