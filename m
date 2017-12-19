From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 19 Dec 2017 15:01:28 +0530
Subject: [PATCH 2/7] ARM: dts: DRA74x: Use PCIe compatible specific to dra74
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Message-ID: <20171219093133.16565-3-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dra74 specific compatible string for PCIe while preserving
the older compatible. While at that add a new label for the
2nd instance of pcie.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi   |  2 +-
 arch/arm/boot/dts/dra74x.dtsi | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9966d82dbd7c..333f6a634ff9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -349,7 +349,7 @@
 			ranges = <0x51800000 0x51800000 0x3000
 				  0x0	     0x30000000 0x10000000>;
 			status = "disabled";
-			pcie at 51800000 {
+			pcie2_rc: pcie at 51800000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 24e6746c5b26..a001eecf3b14 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -124,3 +124,15 @@
 		status = "disabled";
 	};
 };
+
+&pcie1_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
+
+&pcie1_ep {
+	compatible = "ti,dra746-pcie-ep", "ti,dra7-pcie-ep";
+};
+
+&pcie2_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
-- 
2.11.0
