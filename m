From: pengw@nvidia.com (Bryan Wu)
Date: Wed, 2 Jan 2013 15:53:50 -0800
Subject: [PATCH 1/2] ARM: DT: tegra: Add board level compatible properties
Message-ID: <1357170831-7836-1-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible properties of Tegra SoC based boards or machines need
to be documented. This patch adds these board levle compatible
properties into device tree binding document.

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 Documentation/devicetree/bindings/arm/tegra.txt |   29 ++++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 6e69d2e..665c54d 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -1,14 +1,31 @@
 NVIDIA Tegra device tree bindings
 -------------------------------------------
 
-Boards with the tegra20 SoC shall have the following properties:
+SoCs
+-------------------------------------------
 
-Required root node property:
+Each device tree must specify which Tegra SoC it uses, using one of the
+following compatible values:
 
-compatible = "nvidia,tegra20";
+  nvidia,tegra20
+  nvidia,tegra30
 
-Boards with the tegra30 SoC shall have the following properties:
+Boards
+-------------------------------------------
 
-Required root node property:
+Each device tree must specify which one or more of the following
+board-specific compatible values:
 
-compatible = "nvidia,tegra30";
+  ad,medcom-wide
+  ad,plutux
+  ad,tamonten
+  ad,tec
+  compal,paz00
+  compulab,trimslice
+  nvidia,cardhu
+  nvidia,cardhu-a02
+  nvidia,cardhu-a04
+  nvidia,harmony
+  nvidia,seaboard
+  nvidia,ventana
+  nvidia,whistler
-- 
1.7.10.4
