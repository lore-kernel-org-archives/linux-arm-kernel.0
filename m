From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sun, 23 Dec 2012 11:34:36 +0900
Subject: [PATCH 3/4] ARM: Kirkwood: Add pinctrl of NAND to 88f6282
In-Reply-To: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
References: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1356230077-15340-3-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index ad63b88..e0a779c 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -5,6 +5,12 @@
 			compatible = "marvell,88f6282-pinctrl";
 			reg = <0x10000 0x20>;
 
+			pmx_nand: pmx-nand {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+							"mpp4", "mpp5", "mpp18", "mpp19";
+				marvell,function = "nand";
+			};
+
 			pmx_sata0: pmx-sata0 {
 				marvell,pins = "mpp5", "mpp21", "mpp23";
 				marvell,function = "sata0";
-- 
1.7.10.4
