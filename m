From: nm@ti.com (Nishanth Menon)
Date: Wed, 5 Sep 2018 11:20:23 -0500
Subject: [PATCH 2/3] arm64: dts: ti: am654: Add secure proxy instance for main
 domain
In-Reply-To: <20180905162024.28243-1-nm@ti.com>
References: <20180905162024.28243-1-nm@ti.com>
Message-ID: <20180905162024.28243-3-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add secure proxy instance for Main domain

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 674a266066ca..adcd6341e40c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -29,6 +29,17 @@
 		};
 	};
 
+	secure_proxy_main: mailbox at 32c00000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x32c00000 0x00 0x100000>,
+		      <0x00 0x32400000 0x00 0x100000>,
+		      <0x00 0x32800000 0x00 0x100000>;
+		interrupt-names = "rx_011";
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	main_uart0: serial at 2800000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-- 
2.15.1
