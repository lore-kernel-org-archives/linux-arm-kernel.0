From: rjui@broadcom.com (Ray Jui)
Date: Tue, 5 May 2015 11:13:23 -0700
Subject: [PATCH v7 6/6] clk: cygnus: remove Cygnus dummy clock binding
In-Reply-To: <1430849603-15849-1-git-send-email-rjui@broadcom.com>
References: <1430849603-15849-1-git-send-email-rjui@broadcom.com>
Message-ID: <1430849603-15849-7-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove old Cygnus dummy clock binding document, as it's replaced by
Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 .../devicetree/bindings/clock/bcm-cygnus-clock.txt |   34 --------------------
 1 file changed, 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt b/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
deleted file mode 100644
index 00d26ed..0000000
--- a/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Broadcom Cygnus Clocks
-
-This binding uses the common clock binding:
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Currently various "fixed" clocks are declared for peripheral drivers that use
-the common clock framework to reference their core clocks. Proper support of
-these clocks will be added later
-
-Device tree example:
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		osc: oscillator {
-			compatible = "fixed-clock";
-			#clock-cells = <1>;
-			clock-frequency = <25000000>;
-		};
-
-		apb_clk: apb_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <1000000000>;
-		};
-
-		periph_clk: periph_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <500000000>;
-		};
-	};
-- 
1.7.9.5
