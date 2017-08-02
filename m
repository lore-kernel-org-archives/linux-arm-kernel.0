From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:54:40 +0800
Subject: [PATCH v2 20/23] ARM: dts: rockchip: add saradc support for rv1108
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501664080-12826-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add saradc device tree node for rv1108 soc

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- add compatible string "rockchip,rv1108-saradc"

 arch/arm/boot/dts/rv1108.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 592aba3..f87f6f8 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -275,6 +275,18 @@
 		status = "disabled";
 	};
 
+	adc: adc at 1038c000 {
+		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
+		reg = <0x1038c000 0x100>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+		clock-frequency = <1000000>;
+		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		status = "disabled";
+	};
+
 	i2c0: i2c at 20000000 {
 		compatible = "rockchip,rv1108-i2c";
 		reg = <0x20000000 0x1000>;
-- 
2.7.4
