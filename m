From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 28 Aug 2017 11:26:10 +0200
Subject: [PATCH] arm64: dts: draak: Add serial console pins
Message-ID: <1503912370-20180-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control for SCIF2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be applied after v4.14-rc1, when commit 794a6711764658a1 ("pinctrl:
sh-pfc: Initial R8A77995 PFC support") has hit mainline.

Else the serial console will fail, reporting (on earlycon):

    sh-sci e6e88000.serial: could not find pctldev for node /soc/pin-controller at e6060000/scif2, deferring probe
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index d144370051d559fc..19c5462d8b678bde 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -36,7 +36,18 @@
 	clock-frequency = <48000000>;
 };
 
+&pfc {
+	scif2_pins: scif2 {
+		groups = "scif2_data";
+		function = "scif2";
+	};
+
+};
+
 &scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
-- 
2.7.4
