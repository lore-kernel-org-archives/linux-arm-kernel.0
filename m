From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 19:26:07 +0800
Subject: [PATCH v2 1/2] dt-bindings: add bindings doc for hi3798cv200 combphy
In-Reply-To: <1508757968-22729-1-git-send-email-shawnguo@kernel.org>
References: <1508757968-22729-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508757968-22729-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianguo Sun <sunjianguo1@huawei.com>

It adds the device tree bindings for PCIE/SATA/USB3 combo PHY found on
HiSilicon STB SoCs.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/phy/phy-hi3798cv200-combphy.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
new file mode 100644
index 000000000000..5fd548f078f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
@@ -0,0 +1,19 @@
+HiSilicon STB PCIE/SATA/USB3 PHY
+
+Properties:
+- compatible: Should be "hisilicon,hi3798cv200-combphy"
+- #phy-cells: Should be 1.  The cell number is used to select the phy mode
+  as defined in <dt-bindings/phy/phy.h>.
+- clocks: The phandle to clock provider and clock specifier pair.
+- resets: The phandle to reset controller and reset specifier pair.
+- hisilicon,peripheral-syscon: The phandle to the peripheral controller.
+
+Example:
+
+combphy1: phy {
+	compatible = "hisilicon,hi3798cv200-combphy";
+	#phy-cells = <1>;
+	clocks = <&crg HISTB_COMBPHY1_CLK>;
+	resets = <&crg 0x188 12>;
+	hisilicon,peripheral-syscon = <&peri_ctrl>;
+};
-- 
1.9.1
