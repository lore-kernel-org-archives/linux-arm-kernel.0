From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Thu, 21 Apr 2016 14:48:41 +0530
Subject: [PATCH 4/6] dt: Add Shared MDIO Controller node for NS2
In-Reply-To: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1461230323-27891-5-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NS2 Shared MDIO Controller DT node having eth phy as child.
This node represents the NS2 AMAC eth phy.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ce0ab84..2944418 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -87,3 +87,18 @@
 		#size-cells = <1>;
 	};
 };
+
+&iproc_shared_mdio {
+	eth-master at 0 {
+		compatible = "brcm,iproc-mdio-master-eth";
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "ok";
+
+		gphy0: eth-phy at 10 {
+			reg = <0x10>;
+			phy-mode = "mii";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 6f81c9d..5b98c81 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -330,6 +330,14 @@
 			      <0x65260000 0x1000>;
 		};
 
+		iproc_shared_mdio: iproc_shared_mdio at 6602023c {
+			compatible = "brcm,iproc-shared-mdio";
+			reg = <0x6602023c 0x14>;
+			reg-names = "mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		timer0: timer at 66030000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x66030000 0x1000>;
-- 
1.9.1
