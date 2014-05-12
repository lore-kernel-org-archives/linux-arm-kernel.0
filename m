From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 12 May 2014 18:06:29 +0200
Subject: [PATCH 01/12] clk: st: Update ST clock binding documentation
In-Reply-To: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399910800-12847-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new compatibilities to support STiH407 SoC.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/clock/st/st,clkgen-mux.txt   |  2 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt   |  5 ++++-
 .../devicetree/bindings/clock/st/st,clkgen.txt       | 20 ++++++++++++++++----
 .../devicetree/bindings/clock/st/st,quadfs.txt       |  3 +++
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
index 943e080..2d92fc8 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
@@ -17,7 +17,7 @@ Required properties:
 	"st,stih416-clkgenf-vcc-sd",	"st,clkgen-mux"
 	"st,stih415-clkgen-a9-mux",	"st,clkgen-mux"
 	"st,stih416-clkgen-a9-mux",	"st,clkgen-mux"
-
+	"st,stih407-clkgen-a9-mux",	"st,clkgen-mux"
 
 - #clock-cells : from common clock binding; shall be set to 0.
 
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index 81eb385..b852925 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -19,11 +19,14 @@ Required properties:
 	"st,stih415-plls-c32-ddr",	"st,clkgen-plls-c32"
 	"st,stih416-plls-c32-a9",	"st,clkgen-plls-c32"
 	"st,stih416-plls-c32-ddr",	"st,clkgen-plls-c32"
+	"st,stih407-plls-c32-a0",	"st,clkgen-plls-c32"
+	"st,stih407-plls-c32-a9",	"st,clkgen-plls-c32"
+	"st,stih407-plls-c32-c0_0",	"st,clkgen-plls-c32"
+	"st,stih407-plls-c32-c0_1",	"st,clkgen-plls-c32"
 
 	"st,stih415-gpu-pll-c32",	"st,clkgengpu-pll-c32"
 	"st,stih416-gpu-pll-c32",	"st,clkgengpu-pll-c32"
 
-
 - #clock-cells : From common clock binding; shall be set to 1.
 
 - clocks : From common clock binding
diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
index 49ec5ae..55506c2 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
@@ -24,16 +24,28 @@ address is common of all subnode.
 		quadfs_node {
 			...
 		};
+
+		mux_node {
+			...
+		};
+
+		vcc_node {
+			...
+		};
 		...
 	};
 
 This binding uses the common clock binding[1].
-Each subnode should use the binding discribe in [2]..[4]
+Each subnode should use the binding discribe in [2]..[7]
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/st,quadfs.txt
-[3] Documentation/devicetree/bindings/clock/st,quadfs.txt
-[4] Documentation/devicetree/bindings/clock/st,quadfs.txt
+[2] Documentation/devicetree/bindings/clock/st,clkgen-divmux.txt
+[3] Documentation/devicetree/bindings/clock/st,clkgen-mux.txt
+[4] Documentation/devicetree/bindings/clock/st,clkgen-pll.txt
+[5] Documentation/devicetree/bindings/clock/st,clkgen-prediv.txt
+[6] Documentation/devicetree/bindings/clock/st,vcc.txt
+[7] Documentation/devicetree/bindings/clock/st,quadfs.txt
+
 
 Required properties:
 - reg : A Base address and length of the register set.
diff --git a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
index ec86d62..c0a4045 100644
--- a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
@@ -15,6 +15,9 @@ Required properties:
   "st,stih416-quadfs432",	"st,quadfs"
   "st,stih416-quadfs660-E",	"st,quadfs"
   "st,stih416-quadfs660-F",	"st,quadfs"
+  "st,stih407-quadfs660-C",	"st,quadfs"
+  "st,stih407-quadfs660-D",	"st,quadfs"
+
 
 - #clock-cells : from common clock binding; shall be set to 1.
 
-- 
1.9.1
