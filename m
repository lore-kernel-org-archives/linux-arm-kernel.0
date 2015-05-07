From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  7 May 2015 10:14:58 +0200
Subject: [PATCH] dt-bindings: ARM: Mediatek: use more generic node name in
 examples
Message-ID: <1430986498-7747-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'clock-controller' and 'power-controller' as node names in the
examples rather than the specific names of the units.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt | 2 +-
 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt   | 2 +-
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt    | 2 +-
 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 5af6d73..936166f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -16,7 +16,7 @@ The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
 Example:
 
-apmixedsys: apmixedsys at 10209000 {
+apmixedsys: clock-controller at 10209000 {
 	compatible = "mediatek,mt8173-apmixedsys";
 	reg = <0 0x10209000 0 0x1000>;
 	#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 684da473..f6cd3e4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -22,7 +22,7 @@ dt-bindings/reset-controller/mt*-resets.h
 
 Example:
 
-infracfg: infracfg at 10001000 {
+infracfg: power-controller at 10001000 {
 	compatible = "mediatek,mt8173-infracfg", "syscon";
 	reg = <0 0x10001000 0 0x1000>;
 	#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index fdb45c6..f25b854 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -22,7 +22,7 @@ dt-bindings/reset-controller/mt*-resets.h
 
 Example:
 
-pericfg: pericfg at 10003000 {
+pericfg: power-controller at 10003000 {
 	compatible = "mediatek,mt8173-pericfg", "syscon";
 	reg = <0 0x10003000 0 0x1000>;
 	#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index a425248..f9e9179 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -16,7 +16,7 @@ The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
 Example:
 
-topckgen: topckgen at 10000000 {
+topckgen: power-controller at 10000000 {
 	compatible = "mediatek,mt8173-topckgen";
 	reg = <0 0x10000000 0 0x1000>;
 	#clock-cells = <1>;
-- 
2.1.4
