From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 15 Aug 2016 15:03:42 +0800
Subject: [PATCH v3 2/5] dt-bindings: hisilicon: Add Hip05 and Hip06 system
 controller support
In-Reply-To: <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467170878-24030-1-git-send-email-wangkefeng.wang@huawei.com>
 <1471244625-56331-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1471244625-56331-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hip05 and Hip06 are very similar in design, use better and unified
name for system controller.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 39 ++++++++++++++++------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 83fe816..3f81575 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -175,38 +175,55 @@ Example:
 	};
 
 -----------------------------------------------------------------------
-Hisilicon HiP05 PCIe-SAS system controller
+Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
 
 Required properties:
 - compatible : "hisilicon,pcie-sas-subctrl", "syscon";
 - reg : Register address and size
 
-The HiP05 PCIe-SAS system controller is shared by PCIe and SAS controllers in
-HiP05 Soc to implement some basic configurations.
+The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
+HiP05 or HiP06 Soc to implement some basic configurations.
 
 Example:
-	/* for HiP05 PCIe-SAS system */
-	pcie_sas: system_controller at 0xb0000000 {
+	/* for HiP05 PCIe-SAS sub system */
+	pcie_sas: system_controller at b0000000 {
 		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
 		reg = <0xb0000000 0x10000>;
 	};
 
-Hisilicon HiP05 PERISUB system controller
+Hisilicon HiP05/HiP06 PERI sub system controller
 
 Required properties:
-- compatible : "hisilicon,hip05-perisubc", "syscon";
+- compatible : "hisilicon,peri-subctrl", "syscon";
 - reg : Register address and size
 
-The HiP05 PERISUB system controller is shared by peripheral controllers in
-HiP05 Soc to implement some basic configurations. The peripheral
+The PERI sub system controller is shared by peripheral controllers in
+HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
 controllers include mdio, ddr, iic, uart, timer and so on.
 
 Example:
-	/* for HiP05 perisub-ctrl-c system */
+	/* for HiP05 sub peri system */
 	peri_c_subctrl: syscon at 80000000 {
-		compatible = "hisilicon,hip05-perisubc", "syscon";
+		compatible = "hisilicon,peri-subctrl", "syscon";
 		reg = <0x0 0x80000000 0x0 0x10000>;
 	};
+
+Hisilicon HiP05/HiP06 DSA sub system controller
+
+Required properties:
+- compatible : "hisilicon,dsa-subctrl", "syscon";
+- reg : Register address and size
+
+The DSA sub system controller is shared by peripheral controllers in
+HiP05 or HiP06 Soc to implement some basic configurations.
+
+Example:
+	/* for HiP05 dsa sub system */
+	pcie_sas: system_controller at a0000000 {
+		compatible = "hisilicon,dsa-subctrl", "syscon";
+		reg = <0xa0000000 0x10000>;
+	};
+
 -----------------------------------------------------------------------
 Hisilicon CPU controller
 
-- 
1.7.12.4
