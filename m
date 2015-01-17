From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Sat, 17 Jan 2015 12:08:58 +0900
Subject: [PATCH v3 1/3] dt-bindings: add vendor prefix and root compatible
 property for Rockchip boards
In-Reply-To: <1421464140-29903-1-git-send-email-naobsd@gmail.com>
References: <1421464140-29903-1-git-send-email-naobsd@gmail.com>
Message-ID: <1421464140-29903-2-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds vendor prefix and root compatible property for following boards

- Firefly, Firefly-RK3288 boards (both beta and mass production version)
- ChipSPARK, Rayeager PX2 board

PX2 SoC is fully compatible with RK3066.

Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
---

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
index 5d2251a..0d37f5f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -32,6 +32,7 @@ capella	Capella Microsystems, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 chipidea	Chipidea, Inc
+chipspark	ChipSPARK
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
@@ -62,6 +63,7 @@ everest	Everest Semiconductor Co. Ltd.
 everspin	Everspin Technologies, Inc.
 excito	Excito
 fcs	Fairchild Semiconductor
+firefly	Firefly
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.2.2
