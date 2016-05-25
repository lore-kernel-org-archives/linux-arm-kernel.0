From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 May 2016 17:49:58 +0800
Subject: [PATCH 1/5] dt-bindings: document rk3399 rk-timer bindings
In-Reply-To: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1464169802-6033-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

Add compatible string for rk3399 because which timer is a little
different from older SoCs. So rename the file name from
rockchip,rk3288-timer.txt to rockchip,rk-timer.txt.
Clarify rockchip,rk3288-timer supported SoCs.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 .../timer/{rockchip,rk3288-timer.txt => rockchip,rk-timer.txt}      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/timer/{rockchip,rk3288-timer.txt => rockchip,rk-timer.txt} (75%)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
similarity index 75%
rename from Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt
rename to Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index 87f0b00..a41b184 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -1,7 +1,9 @@
-Rockchip rk3288 timer
+Rockchip rk timer
 
 Required properties:
-- compatible: shall be "rockchip,rk3288-timer"
+- compatible: shall be one of:
+  "rockchip,rk3288-timer" - for rk3066, rk3036, rk3188, rk322x, rk3288, rk3368
+  "rockchip,rk3399-timer" - for rk3399
 - reg: base address of the timer register starting with TIMERS CONTROL register
 - interrupts: should contain the interrupts for Timer0
 - clocks : must contain an entry for each entry in clock-names
-- 
1.9.1
