From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 15:11:54 +0000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd and
 pinctrl trees
In-Reply-To: <20121107142916.824003a6c863320fbf379652@canb.auug.org.au>
References: <20121107142916.824003a6c863320fbf379652@canb.auug.org.au>
Message-ID: <201211081511.54467.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 November 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-nomadik/board-nhk8815.c between commit 1cd2fc449091 ("ARM:
> nomadik: fixup some FSMC merge problems") from the l2-mtd tree, commits
> bb16bd9b9da4 ("pinctrl/nomadik: move the platform data header") from the
> pinctrl and commit 44e47ccf8ab6 ("Merge branch 'next/multiplatform' into
> for-next") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 

Hi Stephen,

I think this one turned out wrong, and is missing this part:

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 5ccdf53..69769b7 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -26,7 +26,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
-#include <linux/platform_data/mtd-nomadik-nand.h>
 #include <asm/hardware/vic.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>


The mtd-nomadik-nand.h inclusion was removed in the l2-mtd tree, but
moved to a different line in the arm-soc tree. It needs to be removed
because the header is gone now.

	Arnd
