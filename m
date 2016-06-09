From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  9 Jun 2016 10:46:50 -0400
Subject: [PATCH v2 2/2] ARM: dts: TS-4800: add CAN support
In-Reply-To: <1465483610-16937-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1465483610-16937-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1465483610-16937-2-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for the CAN controller located in the FPGA.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes in v2:
 - Get rid of "0," in unit-address
 - Move node to keep them sorted by unit-address

 arch/arm/boot/dts/imx51-ts4800.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 0e80fb7..984c71b 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -176,6 +176,16 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		can at 1a000 {
+			compatible = "technologic,sja1000";
+			reg = <0x1a000 0x100>;
+			interrupt-parent = <&fpga_irqc>;
+			interrupts = <1>;
+			reg-io-width = <2>;
+			nxp,tx-output-config = <0x06>;
+			nxp,external-clock-frequency = <24000000>;
+		};
 	};
 };
 
-- 
2.5.0
