From: pma@sysgo.com (Pavel Machek)
Date: Tue, 16 Nov 2010 10:07:05 +0100
Subject: suspicious code in linux/arch/arm/common/sa1111.c
Message-ID: <20101116090705.GA29337@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Is this good idea?

Signed-off-by: Pavel Machek <pma@sysgo.com>

diff -ur linux.ofic//arch/arm/common/sa1111.c linux/arch/arm/common/sa1111.c
--- linux.ofic//arch/arm/common/sa1111.c	2010-10-17 20:31:13.000000000 +0200
+++ linux/arch/arm/common/sa1111.c	2010-11-05 10:44:17.000000000 +0100
@@ -282,7 +312,7 @@
 	for (i = 0; i < 8; i++) {
 		sa1111_writel(ip0 ^ mask, mapbase + SA1111_INTPOL0);
 		sa1111_writel(ip0, mapbase + SA1111_INTPOL0);
-		if (sa1111_readl(mapbase + SA1111_INTSTATCLR1) & mask)
+		if (sa1111_readl(mapbase + SA1111_INTSTATCLR0) & mask)
 			break;
 	}
 
