From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 7 Oct 2013 15:31:24 +0800
Subject: [PATCH 6/7] HACK: arm: tegra: reuse the Tegra114 clock driver for
 Tegra124 UART-A
In-Reply-To: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381131085-26116-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is only a hack for Tegra124 bring up testing. Please don't
merge this. The same function can be replaced by Tegra124 clock driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 6d0d737..dd60f88 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/clock/tegra114-car.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -29,6 +30,12 @@
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	tegra_car: clock {
+		compatible = "nvidia,tegra114-car";
+		reg = <0x60006000 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
@@ -43,6 +50,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA114_CLK_UARTA>;
 	};
 
 	serial at 70006040 {
-- 
1.8.4
