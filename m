From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 23:04:14 +0200
Subject: [PATCH v2 1/3] clk: si5351: Mention clock-names in the binding
 documentation
In-Reply-To: <1430773456-15203-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430773456-15203-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430773456-15203-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the introduction of clk-si5351 the way we should deal with DT provided
clocks has changed from indexed to named clock phandles. Amend the binding
documentation to reflect named clock phandles by clock-names property.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Documentation/devicetree/bindings/clock/silabs,si5351.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.txt b/Documentation/devicetree/bindings/clock/silabs,si5351.txt
index c40711e8e8f7..28b28309f535 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.txt
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.txt
@@ -17,7 +17,8 @@ Required properties:
 - #clock-cells: from common clock binding; shall be set to 1.
 - clocks: from common clock binding; list of parent clock
   handles, shall be xtal reference clock or xtal and clkin for
-  si5351c only.
+  si5351c only. Corresponding clock input names are "xtal" and
+  "clkin" respectively.
 - #address-cells: shall be set to 1.
 - #size-cells: shall be set to 0.
 
@@ -71,6 +72,7 @@ i2c-master-node {
 
 		/* connect xtal input to 25MHz reference */
 		clocks = <&ref25>;
+		clock-names = "xtal";
 
 		/* connect xtal input as source of pll0 and pll1 */
 		silabs,pll-source = <0 0>, <1 0>;
-- 
2.1.0
