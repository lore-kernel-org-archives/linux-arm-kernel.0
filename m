From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 14 Dec 2015 16:42:37 +0100
Subject: [PATCH 5/6] pinctrl: sh-pfc: r8a7795: add SATA0 pin conf to DT
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450107758-2544-6-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 297c9f0..3d6c1e0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -140,6 +140,10 @@
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	sata0_pins: sata0 {
+		renesas,groups = "sata0_devslp_a";
+		renesas,function = "sata0";
+	};
 	scif1_pins: scif1 {
 		renesas,groups = "scif1_data_a", "scif1_ctrl";
 		renesas,function = "scif1";
@@ -269,6 +273,9 @@
 };
 
 &sata {
+	pinctrl-0 = <&sata0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
-- 
2.6.3
