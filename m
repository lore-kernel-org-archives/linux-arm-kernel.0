From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:29 +0300
Subject: [PATCH v7 2/7] dt-bindings: clarify compatible property for rockchip
 timers
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-3-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make all properties description in form '"rockchip,<chip>-timer",
"rockchip,rk3288-timer"' for all chips found in linux kernel.

Suggested-by: Heiko St?bner <heiko@sntech.de>
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/timer/rockchip,rk-timer.txt           |   12 +++++++++---
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
1.7.9.5
