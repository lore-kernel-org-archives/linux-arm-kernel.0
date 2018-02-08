From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu,  8 Feb 2018 20:20:33 +0800
Subject: [PATCH v8 3/3] ARM: dts: rockchip: enable sfc for rv1108 evb
In-Reply-To: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1518092433-3893-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the sfc support for rv1108 evaluation board.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 10 ++++++++++
 arch/arm/boot/dts/rv1108.dtsi    | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index ac27e11..5d0ebe3 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -239,6 +239,16 @@
 	};
 };
 
+&sfc {
+	status = "okay";
+	spi-nor at 0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 76ea246..30435fc 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -554,6 +554,19 @@
 		status = "disabled";
 	};
 
+	sfc: sfc at 301c0000 {
+		compatible = "rockchip,rv1108-sfc", "rockchip,sfc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "sfc", "hsfc";
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x301c0000 0x1000>;
+		/* If you want to use PIO mode, activate this */
+		/*rockchip,sfc-no-dma;*/
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at 32010000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.7.4
