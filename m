From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 25 Nov 2016 01:10:55 +0300
Subject: [PATCH] dt-bindings: clarify compatible field usage for rockchip
 timers
Message-ID: <1480025455-6797-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3036 dtsi file already use compatible field as
"rockchip,rk3036-timer", "rockchip,rk3288-timer".

The patch clearly shows how that filed should be used on other chips.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 .../bindings/timer/rockchip,rk-timer.txt           |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index a41b184..7bc9691 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -1,9 +1,15 @@
 Rockchip rk timer
 
 Required properties:
-- compatible: shall be one of:
-  "rockchip,rk3288-timer" - for rk3066, rk3036, rk3188, rk322x, rk3288, rk3368
-  "rockchip,rk3399-timer" - for rk3399
+- compatible: should be:
+  "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
+  "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
+  "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
+  "rockchip,rk322x-timer", "rockchip,rk3288-timer": for Rockchip RK322X
+   (please replace rk322x with exact device name and update this file)
+  "rockchip,rk3288-timer": for Rockchip RK3288
+  "rockchip,rk3368-timer", "rockchip,rk3288-timer": for Rockchip RK3368
+  "rockchip,rk3399-timer": for Rockchip RK3399
 - reg: base address of the timer register starting with TIMERS CONTROL register
 - interrupts: should contain the interrupts for Timer0
 - clocks : must contain an entry for each entry in clock-names
-- 
1.7.9.5
