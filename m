From: stefan@agner.ch (Stefan Agner)
Date: Fri,  1 Apr 2016 23:13:40 -0700
Subject: [PATCH 2/3] ARM: dts: vf-colibri: increase NAND clock speed
In-Reply-To: <1459577621-3160-1-git-send-email-stefan@agner.ch>
References: <1459577621-3160-1-git-send-email-stefan@agner.ch>
Message-ID: <1459577621-3160-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND flash memory populated on Colibri VF61 allows faster NAND
timings than the flash memory on VF50. Additionally, due to divider
limitations, VF61 did clock the flash even slower than VF50. Assign
the NFC clock in the module specific device trees vf500-colibri.dtsi
and vf610-colibri.dtsi respectively.

This increases raw read speed on Colibri VF61 by about 20%.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi    | 2 --
 arch/arm/boot/dts/vf500-colibri.dtsi | 5 +++++
 arch/arm/boot/dts/vf610-colibri.dtsi | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 7529dd7..226a86f 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -130,8 +130,6 @@
 };
 
 &nfc {
-	assigned-clocks = <&clks VF610_CLK_NFC>;
-	assigned-clock-rates = <33000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nfc>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index 3fe1f48..1a8a0ef 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -69,6 +69,11 @@
 	};
 };
 
+&nfc {
+	assigned-clocks = <&clks VF610_CLK_NFC>;
+	assigned-clock-rates = <33000000>;
+};
+
 &iomuxc {
 	vf610-colibri {
 		pinctrl_touchctrl_idle: touchctrl_idle {
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index ab4a29f..9ec9e33 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -50,3 +50,8 @@
 		reg = <0x80000000 0x10000000>;
 	};
 };
+
+&nfc {
+	assigned-clocks = <&clks VF610_CLK_NFC>;
+	assigned-clock-rates = <50000000>;
+};
-- 
2.7.4
