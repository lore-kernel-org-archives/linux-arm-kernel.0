From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:08:56 +0200
Subject: [PATCH v2 01/16] pwm: samsung: Update DT bindings documentation to
 cover clocks
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM driver consumes at least one and up to three clocks, which need to be
specified in device tree when used. This patch updates bindings
documentation to add information about clocks.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index 4caa1a7..d61fccd 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -19,6 +19,16 @@ Required properties:
 - reg: base address and size of register area
 - interrupts: list of timer interrupts (one interrupt per timer, starting at
   timer 0)
+- clock-names: should contain all following required clock names:
+    - "timers" - PWM base clock used to generate PWM signals,
+  and any subset of following optional clock names:
+    - "pwm-tclk0" - first external PWM clock source,
+    - "pwm-tclk1" - second external PWM clock source.
+  Note that not all IP variants allow using all external clock sources.
+  Refer to SoC documentation to learn which clock source configurations
+  are available.
+- clocks: should contain clock specifiers of all clocks, which input names
+  have been specified in clock-names property, in same order.
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -34,6 +44,8 @@ Example:
 		reg = <0x7f006000 0x1000>;
 		interrupt-parent = <&vic0>;
 		interrupts = <23>, <24>, <25>, <27>, <28>;
+		clocks = <&clock 67>;
+		clock-names = "timers";
 		samsung,pwm-outputs = <0>, <1>;
 		#pwm-cells = <3>;
 	}
-- 
1.8.3.2
