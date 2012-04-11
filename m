From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 18:01:14 +0200
Subject: [PATCH 4/9] ARM: at91: USB A926x update nand partition
In-Reply-To: <20120411153515.GK16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
Message-ID: <1334160079-30831-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now store the dtb in a nand partition.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/usb_a9g20.dts      |   11 ++++++++---
 arch/arm/mach-at91/board-usb-a926x.c |    4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 7c2399c..0f88ec8 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -74,19 +74,24 @@
 				reg = <0x80000 0x20000>;
 			};
 
+			oftree at 80000 {
+				label = "oftree";
+				reg = <0xa0000 0x20000>;
+			};
+
 			kernel at a0000 {
 				label = "kernel";
-				reg = <0xa0000 0x400000>;
+				reg = <0xc0000 0x400000>;
 			};
 
 			rootfs at 4a0000 {
 				label = "rootfs";
-				reg = <0x4a0000 0x7800000>;
+				reg = <0x4c0000 0x7800000>;
 			};
 
 			data at 7ca0000 {
 				label = "data";
-				reg = <0x7ca0000 0x8360000>;
+				reg = <0x7cc0000 0x8340000>;
 			};
 		};
 
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 332ecd4..95393fc 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -172,6 +172,10 @@ static struct mtd_partition __initdata ek_nand_partition[] = {
 		.offset	= MTDPART_OFS_NXTBLK,
 		.size	= SZ_128K,
 	}, {
+		.name	= "oftree",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= SZ_128K,
+	}, {
 		.name	= "kernel",
 		.offset	= MTDPART_OFS_NXTBLK,
 		.size	= 4 * SZ_1M,
-- 
1.7.9.1
