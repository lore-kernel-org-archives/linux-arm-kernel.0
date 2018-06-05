From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:16:29 -0500
Subject: [RFC PATCH 8/8] arm64: dts: ti: k3-am6: Add Secure Proxy instance
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
Message-ID: <20180605061629.4759-9-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Secure Proxy instances in AM6 family of SoCs.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
index cdfa12173aac..07e9cc05519c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
@@ -86,6 +86,17 @@
 			};
 		};
 
+		secure_proxy: secure_proxy at 32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x0 0x32c00000 0x0 0x100000>,
+			      <0x0 0x32400000 0x0 0x100000>,
+			      <0x0 0x32800000 0x0 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		wkup_uart0: serial at 42300000 {
 			compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
 			reg = <0x0 0x42300000 0x0 0x100>;
-- 
2.15.1
