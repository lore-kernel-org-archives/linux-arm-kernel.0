From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:43 +0930
Subject: [PATCH 3/9] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-4-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/clock/aspeed-clock.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/aspeed-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/aspeed-clock.txt b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
new file mode 100644
index 000000000000..4259f0986739
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
@@ -0,0 +1,44 @@
+Device Tree Clock bindings for the Aspeed AST2400
+
+Aspeed SoCs have a fixed frequency input osciallator is usd to create the PLL
+and APB clocks. We can determine these frequencies by reading registers that
+are set according to strapping bits.
+
+PLL:
+
+Required properties:
+- compatible : Must be "aspeed,ast2400-pll-clock"
+- #clock-cells : Should be 0
+- reg : Should contain registers location and length
+- clocks : Should contain phandle + clock-specifier for the input clock
+
+Optional properties:
+- clock-output-names : Should contain clock name
+
+
+APB:
+
+Required properties:
+- compatible : Must be "aspeed,ast2400-apb-clock"
+- #clock-cells : Should be 0
+- reg : Should contain registers location and length
+- clocks : Should contain phandle + clock-specifier for the the pll
+
+Optional properties:
+- clock-output-names : Should contain clock name
+
+
+For example:
+
+	clk_hpll: clk_hpll {
+		compatible = "aspeed,ast2400-pll-clock";
+		#clock-cells = <0>;
+		reg = <0x1e6e2008 0x4>;
+	};
+
+	clk_apb: clk_apb at 1e6e2008 {
+		#clock-cells = <0>;
+		compatible = "aspeed,ast2400-apb-clock";
+		reg = <0x1e6e2008 0x4>;
+		clocks = <&clk_hpll>;
+	};
-- 
2.7.4
