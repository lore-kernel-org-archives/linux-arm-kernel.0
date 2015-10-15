From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 15 Oct 2015 12:17:49 +0530
Subject: [PATCH v3 09/12] dts/ls2080a: Update Simulator DTS to add support of
 various peripherals
In-Reply-To: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1444891672-32117-10-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the LS2080a simulator DTS to add support of various
peripherals which are supported on the simulator platform and explicitly
disables those which are yet not supported on the platform.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   54 ++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 33d6d0c..70b0fb4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -57,9 +57,63 @@
 	model = "Freescale Layerscape 2080a software Simulator model";
 	compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
 	ethernet at 2210000 {
 		compatible = "smsc,lan91c111";
 		reg = <0x0 0x2210000 0x0 0x100>;
 		interrupts = <0 58 0x1>;
 	};
 };
+
+&esdhc {
+	status = "disabled";
+};
+
+&ifc {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	status = "disabled";
+};
+
+&dspi {
+	status = "disabled";
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&sata0 {
+	status = "disabled";
+};
+
+&sata1 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "disabled";
+};
+
+&usb1 {
+	status = "disabled";
+};
+
-- 
1.7.9.5
