From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 19:01:43 +0800
Subject: [PATCH 2/2] dt-bindings: add document for rockchip dp phy
In-Reply-To: <1455534071-31230-1-git-send-email-ykk@rock-chips.com>
References: <1455534071-31230-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455534103-31333-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt binding documentation for rockchip display port PHY.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changes in v12: None
Changes in v11:
- Correct the title of this rockchip dp phy document(Rob)
- Add the ack from Rob Herring

Changes in v10: None
Changes in v9: None
Changes in v8:
- Remove the specific address in the example node name. (Heiko)

Changes in v7:
- Simplify the commit message. (Kishon)

Changes in v5:
- Split binding doc's from driver changes. (Rob)
- Update the rockchip,grf explain in document, and correct the clock required
  elemets in document. (Rob & Heiko)

Changes in v4: None
Changes in v3: None

 .../devicetree/bindings/phy/rockchip-dp-phy.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
new file mode 100644
index 0000000..50c4f9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
@@ -0,0 +1,22 @@
+Rockchip specific extensions to the Analogix Display Port PHY
+------------------------------------
+
+Required properties:
+- compatible : should be one of the following supported values:
+	 - "rockchip.rk3288-dp-phy"
+- clocks: from common clock binding: handle to dp clock.
+	of memory mapped region.
+- clock-names: from common clock binding:
+	Required elements: "24m"
+- rockchip,grf: phandle to the syscon managing the "general register files"
+- #phy-cells : from the generic PHY bindings, must be 0;
+
+Example:
+
+edp_phy: edp-phy {
+	compatible = "rockchip,rk3288-dp-phy";
+	rockchip,grf = <&grf>;
+	clocks = <&cru SCLK_EDP_24M>;
+	clock-names = "24m";
+	#phy-cells = <0>;
+};
-- 
1.9.1
