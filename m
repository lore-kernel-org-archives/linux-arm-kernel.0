From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Mar 2014 12:16:43 -0300
Subject: [PATCH 5/6] ARM: mvebu: Enable NAND controller in Armada 385-DB
In-Reply-To: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394637404-7651-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385-DB board has a NAND flash, so enable it in the
devicetree and add the partitions as prepared in the factory images.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 9a13642..b21e9b2 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -80,6 +80,27 @@
 					reg = <1>;
 				};
 			};
+
+			nand: nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "U-Boot";
+					reg = <0 0x800000>;
+				};
+				partition at 800000 {
+					label = "Linux";
+					reg = <0x800000 0x800000>;
+				};
+				partition at 1000000 {
+					label = "Filesystem";
+					reg = <0x1000000 0x3f000000>;
+				};
+			};
 		};
 
 		pcie-controller {
-- 
1.9.0
