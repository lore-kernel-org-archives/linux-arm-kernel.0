From: markus.mayer@linaro.org (Markus Mayer)
Date: Mon, 30 Sep 2013 11:39:13 -0700
Subject: [PATCH v2] ARM: dts: bcm281xx: Add card detect GPIO
Message-ID: <1380566353-13815-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register GPIO 14 as card detect interrupt for the SD card slot.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---

Changes since v1:
- Corrected commit message to mention "card detect"

 arch/arm/boot/dts/bcm11351.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 05a5aab..d384ed5 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -93,6 +93,7 @@
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <0x0 73 0x4>;
+		cd-gpios = <&gpio 14 0>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
