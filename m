From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  9 Apr 2018 15:38:44 +0900
Subject: [PATCH net-next 2/3] dt-bindings: net: ave: add syscon-phy-mode
 property to configure phy-mode setting
In-Reply-To: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1523255925-6469-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "socionext,syscon-phy-mode" property to specify system controller that
configures the settings about phy-mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
index 85e0c49..fc8f017 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -13,7 +13,8 @@ Required properties:
  - reg: Address where registers are mapped and size of region.
  - interrupts: Should contain the MAC interrupt.
  - phy-mode: See ethernet.txt in the same directory. Allow to choose
-	"rgmii", "rmii", or "mii" according to the PHY.
+	"rgmii", "rmii", "mii", or "internal" according to the PHY.
+	The acceptable mode is SoC-dependent.
  - phy-handle: Should point to the external phy device.
 	See ethernet.txt file in the same directory.
  - clocks: A phandle to the clock for the MAC.
@@ -27,6 +28,8 @@ Required properties:
  - reset-names: Should contain
 	- "ether", "gio" for Pro4 SoC
 	- "ether" for others
+ - socionext,syscon-phy-mode: A phandle to syscon with one argument
+	that configures phy mode. The argument is the ID of MAC instance.
 
 Optional properties:
  - local-mac-address: See ethernet.txt in the same directory.
@@ -47,6 +50,7 @@ Example:
 		clocks = <&sys_clk 6>;
 		reset-names = "ether";
 		resets = <&sys_rst 6>;
+		socionext,syscon-phy-mode = <&soc_glue 0>;
 		local-mac-address = [00 00 00 00 00 00];
 
 		mdio {
-- 
2.7.4
