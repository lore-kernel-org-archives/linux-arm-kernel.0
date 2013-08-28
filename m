From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 28 Aug 2013 15:16:13 -0700
Subject: [PATCH v5 3/3] ARM: bcm281xx: Add device node for the GPIO controller
In-Reply-To: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
References: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1377728173-30711-4-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GPIO controller device node for the Broadcom bcm281xx family of
chips

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index c0cdf66..a3945e3 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -63,6 +63,22 @@
 		clock-frequency = <32768>;
 	};
 
+	gpio: gpio at 35003000 {
+		compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
+		reg = <0x35003000 0x800>;
+		interrupts =
+		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
+			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
+			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+			GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
+			GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+	};
+
 	sdio0: sdio at 0x3f180000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
-- 
1.7.9.5
