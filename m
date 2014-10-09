From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu,  9 Oct 2014 14:39:05 +0200
Subject: [PATCH RFT 7/8] ARM: berlin: Add BG2CD ethernet DT nodes
In-Reply-To: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1412858346-11334-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell BG2CD has two fast ethernet controllers with internal PHY,
add the corresponding nodes to SoC dtsi.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: netdev at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2cd.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 68f7032b4686..ee3a22ad4b5f 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -66,6 +66,42 @@
 			clocks = <&chip CLKID_TWD>;
 		};
 
+		eth1: ethernet at b90000 {
+			compatible = "marvell,pxa168-eth";
+			reg = <0xb90000 0x10000>;
+			clocks = <&chip CLKID_GETH1>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			/* set by bootloader */
+			local-mac-address = [00 00 00 00 00 00];
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy-handle = <&ethphy1>;
+			status = "disabled";
+
+			ethphy1: ethernet-phy at 0 {
+				phy-connection-type = "mii";
+				reg = <0>;
+			};
+		};
+
+		eth0: ethernet at e50000 {
+			compatible = "marvell,pxa168-eth";
+			reg = <0xe50000 0x10000>;
+			clocks = <&chip CLKID_GETH0>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			/* set by bootloader */
+			local-mac-address = [00 00 00 00 00 00];
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy-handle = <&ethphy0>;
+			status = "disabled";
+
+			ethphy0: ethernet-phy at 0 {
+				phy-connection-type = "mii";
+				reg = <0>;
+			};
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.1.1
