From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:27:12 +0200
Subject: [PATCH 22/29] dt-bindings: Clarify compatible property for rockchip
 timers
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-22-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Kochetkov <al.kochet@gmail.com>

Make all properties description in form '"rockchip,<chip>-timer",
"rockchip,rk3288-timer"' for all chips found in linux kernel.

Suggested-by: Heiko St?bner <heiko@sntech.de>
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/rockchip,rk-timer.txt          | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index a41b184..16a5f45 100644
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
+  "rockchip,rk3228-timer", "rockchip,rk3288-timer": for Rockchip RK3228
+  "rockchip,rk3229-timer", "rockchip,rk3288-timer": for Rockchip RK3229
+  "rockchip,rk3288-timer": for Rockchip RK3288
+  "rockchip,rk3368-timer", "rockchip,rk3288-timer": for Rockchip RK3368
+  "rockchip,rk3399-timer": for Rockchip RK3399
 - reg: base address of the timer register starting with TIMERS CONTROL register
 - interrupts: should contain the interrupts for Timer0
 - clocks : must contain an entry for each entry in clock-names
-- 
2.7.4
