From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 14 May 2010 09:16:11 +0100
Subject: [PATCH 17/20] pxa3xx_nand: add cmdline part parser support
In-Reply-To: <AANLkTikMrVigamYF8VAiEB3_JXGr6LAFliOmw9CJr8mz@mail.gmail.com>
References: <h2l771cded01005060212k39b41e4aqa57cc6e5072bfe3b@mail.gmail.com>
	<1273804364.9999.881.camel@macbook.infradead.org>
	<AANLkTikMrVigamYF8VAiEB3_JXGr6LAFliOmw9CJr8mz@mail.gmail.com>
Message-ID: <1273824971.9999.1582.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-14 at 14:08 +0800, Haojian Zhuang wrote:
> On Fri, May 14, 2010 at 10:32 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Thu, 2010-05-06 at 05:12 -0400, Haojian Zhuang wrote:
> >> From c81c53e24bbbe29ab4bf9767d24de8c45a4470b9 Mon Sep 17 00:00:00 2001
> >> From: Lei Wen <leiwen@marvell.com>
> >> Date: Thu, 6 May 2010 10:42:13 +0800
> >> Subject: [PATCH] pxa3xx_nand: add cmdline part parser support
> >>
> >> Signed-off-by: Lei Wen <leiwen@marvell.com>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> ---
> >>  drivers/mtd/nand/pxa3xx_nand.c |   26 ++++++++++++++++++++++++--
> >>  1 files changed, 24 insertions(+), 2 deletions(-)
> >
> > This conflicts with commit bff3c10d369440bc87ba612b45ba2777d2bf017f.
> >
> > Some of the other patches in this sequence don't apply cleanly to the
> > current mtd-2.6.git tree either; please could you refresh?
> >
> 
> New patches are rebased for mtd-2.6 master branch. There're contained
> in another mail loop.

Hm, please test these by sending to yourself first, saving the patches
and checking that they apply.

[dwmw2 at macbook mtd-2.6]$ git describe HEAD
v2.6.34-rc7-142-gf6b173c

[dwmw2 at macbook mtd-2.6]$ for a in `seq -w 1 20` ; do echo Patch $a ; patch -p1 < pxa$a.patch ; done
Patch 01
patching file arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
patching file drivers/mtd/nand/Kconfig
patching file drivers/mtd/nand/pxa3xx_nand.c
patch: **** malformed patch at line 203: transfering to/from NAND HW");

Patch 02
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 225.
patch: **** malformed patch at line 96: pxa3xx_nand_info *info,

Patch 03
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 succeeded at 117 (offset -35 lines).
Hunk #2 succeeded at 130 (offset -35 lines).
Hunk #3 succeeded at 149 (offset -35 lines).
Hunk #4 succeeded at 159 (offset -35 lines).
patch: **** malformed patch at line 116: pxa3xx_nand_info *info,

Patch 04
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 succeeded at 126 (offset -34 lines).
Hunk #2 FAILED at 1097.
patch: **** malformed patch at line 106: platform_device *pdev)

Patch 05
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #4 succeeded at 108 with fuzz 1.
patch: **** malformed patch at line 130: pxa3xx_nand_info *info,

Patch 06
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 28.
Hunk #2 succeeded at 74 (offset -4 lines).
Hunk #3 FAILED at 335.
Hunk #4 FAILED at 364.
Hunk #5 FAILED at 556.
patch: **** malformed patch at line 391: *mtd, unsigned command,

Patch 07
patching file drivers/mtd/nand/pxa3xx_nand.c
patch: **** malformed patch at line 78: builtin_flash_types[] = {

Patch 08
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 218.
patch: **** malformed patch at line 97: pxa3xx_nand_info *info,

Patch 09
patching file arch/arm/mach-mmp/aspenite.c
patching file arch/arm/mach-mmp/avengers_lite.c
patch: **** malformed patch at line 104: avengers_lite_pin_config_V16F[] __initdata = {

Patch 10
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 29.
Hunk #2 succeeded at 36 (offset -2 lines).
Hunk #3 succeeded at 89 (offset -6 lines).
Hunk #4 FAILED at 132.
Hunk #5 FAILED at 159.
Hunk #6 FAILED at 182.
patch: **** malformed patch at line 164: 60, 10, }, },

Patch 11
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 411.
Hunk #3 FAILED at 456.
patch: **** malformed patch at line 107: *nand, int dir_out)

Patch 12
patching file arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
Hunk #1 succeeded at 12 with fuzz 2 (offset -1 lines).
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 45.
Hunk #3 FAILED at 59.
Hunk #4 FAILED at 89.
Hunk #5 succeeded at 93 with fuzz 2 (offset -46 lines).
Hunk #6 FAILED at 154.
Hunk #7 FAILED at 186.
Hunk #8 FAILED at 209.
patch: **** malformed patch at line 222: using naked command set");

Patch 13
patching file arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
Hunk #1 succeeded at 14 with fuzz 2 (offset -1 lines).
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 succeeded at 60 with fuzz 2 (offset -30 lines).
Hunk #2 FAILED at 187.
Hunk #3 FAILED at 194.
Hunk #4 FAILED at 275.
patch: **** malformed patch at line 215: long nand_clk)

Patch 14
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 26.
Hunk #2 FAILED at 298.
2 out of 2 hunks FAILED -- saving rejects to file drivers/mtd/nand/pxa3xx_nand.c.rej
Patch 15
patching file arch/arm/mach-mmp/include/mach/mmp2.h
patch: **** malformed patch at line 92: i2c_pxa_platform_data *data,

Patch 16
patching file drivers/mtd/nand/pxa3xx_nand.c
patch: **** malformed patch at line 80: pxa3xx_nand *nand, int command,

Patch 17
patching file drivers/mtd/nand/pxa3xx_nand.c
patch: **** malformed patch at line 74: builtin_flash_types[] = {

Patch 18
patching file arch/arm/configs/pxa168_defconfig
patch: **** malformed patch at line 82: nfsroot=192.168.2.100:/nfsroot/

Patch 19
patching file drivers/mtd/nand/pxa3xx_nand.c
Hunk #1 FAILED at 129.
Hunk #2 FAILED at 257.
Hunk #3 FAILED at 646.
patch: **** malformed patch at line 119: void *data)

Patch 20
patching file drivers/mtd/nand/pxa3xx_nand.c
patch: **** malformed patch@line 74: platform_device *pdev)


-- 
dwmw2
