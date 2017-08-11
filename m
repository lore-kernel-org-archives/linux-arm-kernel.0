From: andy.yan@rock-chips.com (Andy Yan)
Date: Fri, 11 Aug 2017 11:42:26 +0800
Subject: [PATCH v3 05/13] ARM: dts: rockchip: add spi dt node for rv1108
In-Reply-To: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1502422946-30885-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI device tree node for rv1108.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rv1108.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 663f2f2..b688f4a 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -200,6 +200,19 @@
 		status = "disabled";
 	};
 
+	spi: spi at 10270000 {
+		compatible = "rockchip,rv1108-spi";
+		reg = <0x10270000 0x1000>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_SPI>, <&cru PCLK_SPI>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&pdma 8>, <&pdma 9>;
+		#dma-cells = <2>;
+		status = "disabled";
+	};
+
 	grf: syscon at 10300000 {
 		compatible = "rockchip,rv1108-grf", "syscon";
 		reg = <0x10300000 0x1000>;
-- 
2.7.4
