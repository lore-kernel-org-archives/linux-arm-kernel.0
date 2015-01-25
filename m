From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Sun, 25 Jan 2015 21:39:34 +0900
Subject: [PATCH v4 1/3] dt-bindings: add vendor prefix and root compatible
 property for Rockchip boards
In-Reply-To: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
References: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
Message-ID: <1422189576-19478-2-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds vendor prefix and root compatible property for following boards

- Firefly, Firefly-RK3288 boards (both beta and mass production version)
- ChipSPARK, Rayeager PX2 board

PX2 SoC is fully compatible with RK3066.

Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
---

Changes in v4: none
Changes in v3: none
Changes in v2:
- use own compatible property for Firefly-RK3288 beta version

 Documentation/devicetree/bindings/arm/rockchip.txt    | 10 ++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index eaa3d1a..6809e4e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -9,6 +9,16 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
 
+- ChipSPARK Rayeager PX2 board:
+    Required root node properties:
+      - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
+
 - Radxa Rock board:
     Required root node properties:
       - compatible = "radxa,rock", "rockchip,rk3188";
+
+- Firefly Firefly-RK3288 board:
+    Required root node properties:
+      - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
+    or
+      - compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6386cb3..851f514 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -34,6 +34,7 @@ capella	Capella Microsystems, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 chipidea	Chipidea, Inc
+chipspark	ChipSPARK
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
@@ -65,6 +66,7 @@ everest	Everest Semiconductor Co. Ltd.
 everspin	Everspin Technologies, Inc.
 excito	Excito
 fcs	Fairchild Semiconductor
+firefly	Firefly
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.2.2
