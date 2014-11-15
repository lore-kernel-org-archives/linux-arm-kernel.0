From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 15 Nov 2014 15:25:04 +0530
Subject: [PATCH V8 09/14] Documentation: drm: bridge: move to video/bridge
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1416045309-13359-10-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move drm/bridge documentation to video/bridge.
Also, add proper documentation for gpios used by ptn3460.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 .../devicetree/bindings/drm/bridge/ptn3460.txt     |   39 --------------------
 .../devicetree/bindings/video/bridge/ptn3460.txt   |   39 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
 create mode 100644 Documentation/devicetree/bindings/video/bridge/ptn3460.txt

diff --git a/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt b/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
deleted file mode 100644
index 663fe6c..0000000
--- a/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-ptn3460 bridge bindings
-
-Required properties:
-	- compatible: "nxp,ptn3460"
-	- reg: i2c address of the bridge
-	- powerdown-gpio: OF device-tree gpio specification
-	- reset-gpio: OF device-tree gpio specification
-	- edid-emulation: The EDID emulation entry to use
-		+-------+------------+------------------+
-		| Value | Resolution | Description      |
-		|   0   |  1024x768  | NXP Generic      |
-		|   1   |  1920x1080 | NXP Generic      |
-		|   2   |  1920x1080 | NXP Generic      |
-		|   3   |  1600x900  | Samsung LTM200KT |
-		|   4   |  1920x1080 | Samsung LTM230HT |
-		|   5   |  1366x768  | NXP Generic      |
-		|   6   |  1600x900  | ChiMei M215HGE   |
-		+-------+------------+------------------+
-
-	- video interfaces: Device node can contain video interface port
-			    nodes for panel according to [1].
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-	lvds-bridge at 20 {
-		compatible = "nxp,ptn3460";
-		reg = <0x20>;
-		powerdown-gpio = <&gpy2 5 1 0 0>;
-		reset-gpio = <&gpx1 5 1 0 0>;
-		edid-emulation = <5>;
-		ports {
-			port at 0 {
-				bridge_out: endpoint {
-					remote-endpoint = <&panel_in>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/video/bridge/ptn3460.txt b/Documentation/devicetree/bindings/video/bridge/ptn3460.txt
new file mode 100644
index 0000000..361971b
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/bridge/ptn3460.txt
@@ -0,0 +1,39 @@
+ptn3460 bridge bindings
+
+Required properties:
+	- compatible: "nxp,ptn3460"
+	- reg: i2c address of the bridge
+	- powerdown-gpio: OF device-tree gpio specification  for PD_N pin.
+	- reset-gpio: OF device-tree gpio specification for RST_N pin.
+	- edid-emulation: The EDID emulation entry to use
+		+-------+------------+------------------+
+		| Value | Resolution | Description      |
+		|   0   |  1024x768  | NXP Generic      |
+		|   1   |  1920x1080 | NXP Generic      |
+		|   2   |  1920x1080 | NXP Generic      |
+		|   3   |  1600x900  | Samsung LTM200KT |
+		|   4   |  1920x1080 | Samsung LTM230HT |
+		|   5   |  1366x768  | NXP Generic      |
+		|   6   |  1600x900  | ChiMei M215HGE   |
+		+-------+------------+------------------+
+
+	- video interfaces: Device node can contain video interface port
+			    nodes for panel according to [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+	lvds-bridge at 20 {
+		compatible = "nxp,ptn3460";
+		reg = <0x20>;
+		powerdown-gpio = <&gpy2 5 1 0 0>;
+		reset-gpio = <&gpx1 5 1 0 0>;
+		edid-emulation = <5>;
+		ports {
+			port at 0 {
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
-- 
1.7.9.5
