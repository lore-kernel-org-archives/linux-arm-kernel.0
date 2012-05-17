From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 May 2012 21:02:16 -0500
Subject: [PATCH v2 1/2] dt: add clock binding doc to primecell bindings
In-Reply-To: <1337220137-31666-1-git-send-email-robherring2@gmail.com>
References: <1337220137-31666-1-git-send-email-robherring2@gmail.com>
Message-ID: <1337220137-31666-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add clock binding information for primecell peripherals. For most, a
clock input name of "apb_pclk" is required. Any primecell peripherals
which are different will need to be documented separately.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/arm/primecell.txt          |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/primecell.txt b/Documentation/devicetree/bindings/arm/primecell.txt
index 951ca46..64fc82b 100644
--- a/Documentation/devicetree/bindings/arm/primecell.txt
+++ b/Documentation/devicetree/bindings/arm/primecell.txt
@@ -13,11 +13,17 @@ Required properties:
 Optional properties:
 
 - arm,primecell-periphid : Value to override the h/w value with
+- clocks : From common clock binding. First clock is phandle to clock for apb
+	pclk. Additional clocks are optional and specific to those peripherals.
+- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
 
 Example:
 
 serial at fff36000 {
 	compatible = "arm,pl011", "arm,primecell";
 	arm,primecell-periphid = <0x00341011>;
+	clocks = <&pclk>;
+	clock-names = "apb_pclk";
+	
 };
 
-- 
1.7.9.5
