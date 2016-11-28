From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 28 Nov 2016 14:31:31 -0500
Subject: [PATCH 2/2] arm64: dts: NS2: enable PAXC on NS2 SVK
In-Reply-To: <1480361491-22221-1-git-send-email-jon.mason@broadcom.com>
References: <1480361491-22221-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1480361491-22221-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the PAXC based PCIe root complex on NS2 SVK. The PAXC based
root complex is connected to internally emulated PCIe endpoints

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts |  4 ++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index de8d379..5ae0816 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -76,6 +76,10 @@
 	status = "ok";
 };
 
+&pcie8 {
+	status = "ok";
+};
+
 &i2c0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 69775a8..96ed47b 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -169,6 +169,23 @@
 		msi-parent = <&v2m0>;
 	};
 
+	pcie8: pcie at 60c00000 {
+		compatible = "brcm,iproc-pcie-paxc";
+		reg = <0 0x60c00000 0 0x1000>;
+		linux,pci-domain = <8>;
+
+		bus-range = <0x0 0x1>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x83000000 0 0x00000000 0 0x60000000 0 0x00c00000>;
+
+		status = "disabled";
+
+		msi-parent = <&v2m0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
