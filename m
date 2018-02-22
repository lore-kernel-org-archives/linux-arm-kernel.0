From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 22 Feb 2018 14:01:20 +0200
Subject: [PATCH v3 09/10] pwm: add documentation for pwm push-pull mode
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1519300881-8136-10-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
 Documentation/pwm.txt                         | 16 ++++++++++++++++
 include/dt-bindings/pwm/pwm.h                 |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index c2b4b9ba0e3f..968dd786ad7c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of flags (defined in
 - PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
 channels two outputs); if not specified, the default for PWM channel will
 be used
+- PWM_DTMODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
+two outputs); if not specified the default for PWM channel will be used
 
 Example with optional PWM specifier for inverse polarity and complementary
 mode:
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 59592f8cc381..174c371583b6 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -128,6 +128,22 @@ channel that was exported. The following properties will then be available:
     PWML1   |__|  |__|  |__|  |__|
             <--T-->
 
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel with 2 outputs, in push-pull mode, with normal
+        polarity looks like this:
+            __          __
+    PWMH __|  |________|  |________
+                  __          __
+    PWML ________|  |________|  |__
+           <--T-->
+
+    If polarity is inversed:
+         __    ________    ________
+    PWMH   |__|        |__|
+         ________    ________    __
+    PWML         |__|        |__|
+           <--T-->
+
     Where T is the signal period.
 
 Implementing a PWM driver
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index b4d61269aced..674dfdd59595 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -12,5 +12,6 @@
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
 #define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
+#define PWM_DTMODE_PUSH_PULL			(1 << 2)
 
 #endif
-- 
2.7.4
