From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 Jan 2016 20:23:50 +0000
Subject: [PATCH 1/3] ARM: dts: imx6qdl-microsom.dtsi: avoid boot-time UHS
 warning
Message-ID: <E1aOWd4-00058O-Mm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the following warning:

sdhci-esdhc-imx 2190000.usdhc: could not get ultra high speed state, work on normal mode

which occurs regularly at boot each time the SDHCI interface for the
Broadcom WiFi is probed at boot.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-microsom.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
index 6d4069cc9419..86460e46d055 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -154,6 +154,7 @@
 	bus-width = <4>;
 	mmc-pwrseq = <&usdhc1_pwrseq>;
 	keep-power-in-suspend;
+	no-1-8-v;
 	non-removable;
 	vmmc-supply = <&reg_brcm>;
 	status = "okay";
-- 
2.1.0
