From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Fri, 23 Nov 2012 06:30:10 +0900
Subject: [PATCH 1/3] ARM: kirkwood: Add support second I2C bus and RTC on
 OpenBlocks A6
Message-ID: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OpenBlocks A6 uses second I2C with RTC of s35390a.
This supports them.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 9a2606c..3f055ad 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -35,5 +35,14 @@
 			nr-ports = <1>;
 			status = "okay";
 		};
+
+		i2c at 11100 {
+			status = "okay";
+
+			s35390a: s35390a at 30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			};
+		};
 	};
 };
-- 
1.7.10.4
