From: tim.kryger@linaro.org (Tim Kryger)
Date: Wed, 16 Oct 2013 14:47:07 -0700
Subject: [RESEND PATCH v2 3/6] ARM: dts: Specify clocks for SDHCIs on bcm11351
In-Reply-To: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1381960030-1640-4-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the external clock label in each SDHCI node.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index ce65367..193659c 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -101,6 +101,7 @@
 	sdio1: sdio at 3f180000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
+		clocks = <&sdio1_clk>;
 		interrupts = <0x0 77 0x4>;
 		status = "disabled";
 	};
@@ -108,6 +109,7 @@
 	sdio2: sdio at 3f190000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
+		clocks = <&sdio2_clk>;
 		interrupts = <0x0 76 0x4>;
 		status = "disabled";
 	};
@@ -115,6 +117,7 @@
 	sdio3: sdio at 3f1a0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
+		clocks = <&sdio3_clk>;
 		interrupts = <0x0 74 0x4>;
 		status = "disabled";
 	};
@@ -122,6 +125,7 @@
 	sdio4: sdio at 3f1b0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
+		clocks = <&sdio4_clk>;
 		interrupts = <0x0 73 0x4>;
 		status = "disabled";
 	};
-- 
1.8.0.1
