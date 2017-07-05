From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  5 Jul 2017 18:13:33 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
Message-ID: <20170705161333.9315-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the PCIe interface on the MACCHIATOBin board. It is located on
CON12 and is 4 lanes capable.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 4968e731de61..e445c80213ab 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -136,6 +136,12 @@
 	vqmmc-supply = <&v_3_3>;
 };
 
+&cpm_pcie0 {
+	/* CON 12 */
+	num-lanes = <4>;
+	status = "okay";
+};
+
 &cpm_usb3_0 {
 	/* J38? - USB2.0 only */
 	status = "okay";
-- 
2.13.2
