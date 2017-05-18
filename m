From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 15:16:48 +0800
Subject: [PATCH v6 4/9] arm64: allwinner: a64: add AXP803 node to Pine64
 device tree
In-Reply-To: <20170518071653.36561-1-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
Message-ID: <20170518071653.36561-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 (including Pine64+) boards have an AXP803 as its main PMIC.

Add its device node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v6:
- Rebase on next-20170517.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 7c533b6d4ba9..36001884ed33 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -107,6 +107,17 @@
 	status = "okay";
 };
 
+&r_rsb {
+	status = "okay";
+
+	axp803: pmic at 3a3 {
+		compatible = "x-powers,axp803";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.12.2
