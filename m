From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 30 Sep 2014 16:28:15 +0200
Subject: [PATCH v6 09/10] ARM: dts: berlin: add the Ethernet node
In-Reply-To: <1412087296-18475-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1412087296-18475-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1412087296-18475-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Ethernet node, enabling the network unit on Berlin
BG2Q SoCs.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/berlin2q.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 902eddb19cd8..d442b22fd1ea 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -114,6 +114,23 @@
 			#interrupt-cells = <3>;
 		};
 
+		eth0: ethernet at b90000 {
+			compatible = "marvell,pxa168-eth";
+			reg = <0xb90000 0x10000>;
+			clocks = <&chip CLKID_GETH0>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			/* set by bootloader */
+			local-mac-address = [00 00 00 00 00 00];
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy-handle = <&ethphy0>;
+			status = "disabled";
+
+			ethphy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+		};
+
 		cpu-ctrl at dd0000 {
 			compatible = "marvell,berlin-cpu-ctrl";
 			reg = <0xdd0000 0x10000>;
-- 
1.9.1
