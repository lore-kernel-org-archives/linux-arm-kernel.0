From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 20 Sep 2013 16:29:58 -0700
Subject: [PATCH] ARM: dts: bcm281xx: Add change disk GPIO
Message-ID: <1379719798-18444-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register GPIO 14 as change disk interrupt for the SD card slot.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---

This patch depends on [PATCH v9 3/3] ARM: bcm281xx: Add device node for
the GPIO controller
(http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/197399.html)
and should therefore likely go into Christian's tree.

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
