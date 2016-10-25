From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 25 Oct 2016 20:35:43 +0800
Subject: [PATCH 4/6] arm64: dts: ls1046a: add MSI dts node
In-Reply-To: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1477398945-22774-4-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1046a has three MSI controllers. each controller is assigned
four SPI interrupts.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 38806ca..5509dca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -511,5 +511,37 @@
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
 		};
+
+		msi: msi-controller {
+			compatible = "fsl,ls-scfg-msi";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			msi-controller;
+
+			msi0 at 1580000 {
+				reg = <0x0 0x1580000 0x0 0x10000>;
+				interrupts = <0 116 0x4>,
+					     <0 111 0x4>,
+					     <0 112 0x4>,
+					     <0 113 0x4>;
+			};
+
+			msi1 at 1590000 {
+				reg = <0x0 0x1590000 0x0 0x10000>;
+				interrupts = <0 126 0x4>,
+					     <0 121 0x4>,
+					     <0 122 0x4>,
+					     <0 123 0x4>;
+			};
+
+			msi2 at 15a0000 {
+				reg = <0x0 0x15a0000 0x0 0x10000>;
+				interrupts = <0 160 0x4>,
+					     <0 155 0x4>,
+					     <0 156 0x4>,
+					     <0 157 0x4>;
+			};
+		};
 	};
 };
-- 
1.9.1
