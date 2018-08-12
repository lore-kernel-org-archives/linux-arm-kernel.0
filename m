From: pn@denx.de (Parthiban Nallathambi)
Date: Sun, 12 Aug 2018 14:22:15 +0200
Subject: [PATCH v2 3/3] arm64: dts: actions: Add sirq node for Actions Semi
 S700
In-Reply-To: <20180812122215.1079590-1-pn@denx.de>
References: <20180812122215.1079590-1-pn@denx.de>
Message-ID: <20180812122215.1079590-4-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sirq node for Actions Semi S700 SoC with 3 SIRQ pins support,
in which external interrupt controllers can be connected.

Example:
atc260x: atc2603c at 65 {
	interrupt-parent = <&sirq>;
	interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
};

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..c5aef5ac7f46 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -153,6 +153,15 @@
 			status = "disabled";
 		};
 
+		sirq: interrupt-controller at e01b0000 {
+			compatible = "actions,owl-sirq";
+			reg = <0 0xe01b0000 0 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			actions,sirq-shared-reg;
+			actions,sirq-offset = <0x200 0x200 0x200>;
+		};
+
 		sps: power-controller at e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.14.4
