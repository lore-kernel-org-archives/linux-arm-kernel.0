From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Fri, 23 Nov 2012 06:30:11 +0900
Subject: [PATCH 2/3] ARM: kirkwood: Add NAND partiton map for OpenBlocks A6
In-Reply-To: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
References: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1353619812-2195-2-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 3f055ad..37dc3a7 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -29,6 +29,36 @@
 		nand at 3000000 {
 			chip-delay = <25>;
 			status = "okay";
+
+			partition at 0 {
+				label = "uboot";
+				reg = <0x0 0x90000>;
+			};
+
+			partition at 90000 {
+				label = "env";
+				reg = <0x90000 0x44000>;
+			};
+
+			partition at d4000 {
+				label = "test";
+				reg = <0xd4000 0x24000>;
+			};
+
+			partition at f4000 {
+				label = "conf";
+				reg = <0xf4000 0x400000>;
+			};
+
+			partition at 4f4000 {
+				label = "linux";
+				reg = <0x4f4000 0x1d20000>;
+			};
+
+			partition at 2214000 {
+				label = "user";
+				reg = <0x2214000 0x1dec000>;
+			};
 		};
 
 		sata at 80000 {
-- 
1.7.10.4
