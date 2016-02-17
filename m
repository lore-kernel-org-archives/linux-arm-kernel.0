From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Feb 2016 11:43:55 +0000
Subject: [PATCH v2 3/8] DT: clk: sunxi: add binding doc for the
 multi-bus-gates clock
In-Reply-To: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455709440-8668-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Allwinner SoCs introduced a bus gates clock which can have
different parents for individual gates.
For the time being we encoded this relation in the driver.
This commit specifies a new binding which allows to encode this in
the DT by using a child node for each parent clock used. This allows
to specify any kind of relation efficiently and also keeps the very
same kernel driver for all SoCs at the same time.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index c09f59b..323af8e 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -79,6 +79,7 @@ Required properties:
 	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
 	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
 	"allwinner,sun4i-a10-ve-clk" - for the Video Engine clock
+	"allwinner,sunxi-multi-bus-gates-clk" - for the multi-parent bus gates
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
@@ -119,6 +120,11 @@ For "allwinner,sun6i-a31-pll6-clk", there are 2 outputs. The first output
 is the normal PLL6 output, or "pll6". The second output is rate doubled
 PLL6, or "pll6x2".
 
+The "allwinner,sunxi-multi-bus-gates-clk" holds the actual clocks in
+child nodes, where each one specifies the parent clock that the particular
+gates are depending from. The child nodes each follow the common clock
+binding as described in this document.
+
 The "allwinner,*-mmc-clk" clocks have three different outputs: the
 main clock, with the ID 0, and the output and sample clocks, with the
 IDs 1 and 2, respectively.
-- 
2.6.4
