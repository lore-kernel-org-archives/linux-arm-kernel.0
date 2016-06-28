From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:24 +0200
Subject: [PATCH 05/92] dt-bindings: Document rk3399 rk-timer bindings
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

Add a compatible string for rk3399 SoC because the timer is slightly different
from the older SoCs. So rename the file name from rockchip,rk3288-timer.txt to
rockchip,rk-timer.txt and clarify rockchip,rk3288-timer supported SoCs.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/rockchip,rk-timer.txt  | 20 ++++++++++++++++++++
 .../bindings/timer/rockchip,rk3288-timer.txt         | 18 ------------------
 2 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
new file mode 100644
index 0000000..a41b184
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -0,0 +1,20 @@
+Rockchip rk timer
+
+Required properties:
+- compatible: shall be one of:
+  "rockchip,rk3288-timer" - for rk3066, rk3036, rk3188, rk322x, rk3288, rk3368
+  "rockchip,rk3399-timer" - for rk3399
+- reg: base address of the timer register starting with TIMERS CONTROL register
+- interrupts: should contain the interrupts for Timer0
+- clocks : must contain an entry for each entry in clock-names
+- clock-names : must include the following entries:
+  "timer", "pclk"
+
+Example:
+	timer: timer at ff810000 {
+		compatible = "rockchip,rk3288-timer";
+		reg = <0xff810000 0x20>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&xin24m>, <&cru PCLK_TIMER>;
+		clock-names = "timer", "pclk";
+	};
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt
deleted file mode 100644
index 87f0b00..0000000
--- a/Documentation/devicetree/bindings/timer/rockchip,rk3288-timer.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Rockchip rk3288 timer
-
-Required properties:
-- compatible: shall be "rockchip,rk3288-timer"
-- reg: base address of the timer register starting with TIMERS CONTROL register
-- interrupts: should contain the interrupts for Timer0
-- clocks : must contain an entry for each entry in clock-names
-- clock-names : must include the following entries:
-  "timer", "pclk"
-
-Example:
-	timer: timer at ff810000 {
-		compatible = "rockchip,rk3288-timer";
-		reg = <0xff810000 0x20>;
-		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names = "timer", "pclk";
-	};
-- 
1.9.1
