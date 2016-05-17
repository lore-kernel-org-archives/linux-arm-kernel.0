From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Tue, 17 May 2016 16:16:30 -0400
Subject: [PATCH 2/2] ARM: dts: TS-4800: add CAN support
In-Reply-To: <1463516190-10606-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1463516190-10606-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1463516190-10606-2-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for the CAN controller located in the FPGA.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx51-ts4800.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 2c89988..41be82e 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -149,6 +149,16 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0x1d000>;
 
+		can at 0,1a000 {
+			compatible = "technologic,sja1000";
+			reg = <0x1a000 0x00000100>;
+			interrupt-parent = <&fpga_irqc>;
+			interrupts = <1>;
+			reg-io-width = <2>;
+			nxp,tx-output-config = <0x06>;
+			nxp,external-clock-frequency = <24000000>;
+		};
+
 		fpga_irqc: fpga_irqc at 0,15000 {
 			compatible = "technologic,ts4800-irqc";
 			reg = <0x15000 0x1000>;
-- 
2.5.0
