From: dianders@chromium.org (Doug Anderson)
Date: Fri,  8 Aug 2014 15:29:09 -0700
Subject: [PATCH] pinctrl: Add mux options 3 and 4 for rockchip pinctrl
Message-ID: <1407536949-31323-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer Rockchip SoCs have more muxing slots.  Add slots 3 and 4 since
the rk3288 table goes all the way up to 4.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt | 6 +++---
 include/dt-bindings/pinctrl/rockchip.h                         | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 4658b69..388b213 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -2,8 +2,8 @@
 
 The Rockchip Pinmux Controller, enables the IC
 to share one PAD to several functional blocks. The sharing is done by
-multiplexing the PAD input/output signals. For each PAD there are up to
-4 muxing options with option 0 being the use as a GPIO.
+multiplexing the PAD input/output signals. For each PAD there are several
+muxing options with option 0 being the use as a GPIO.
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
@@ -58,7 +58,7 @@ Deprecated properties for gpio sub nodes:
 Required properties for pin configuration node:
   - rockchip,pins: 3 integers array, represents a group of pins mux and config
     setting. The format is rockchip,pins = <PIN_BANK PIN_BANK_IDX MUX &phandle>.
-    The MUX 0 means gpio and MUX 1 to 3 mean the specific device function.
+    The MUX 0 means gpio and MUX 1 to N mean the specific device function.
     The phandle of a node containing the generic pinconfig options
     to use, as described in pinctrl-bindings.txt in this directory.
 
diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index cd5788b..743e66a 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -28,5 +28,7 @@
 #define RK_FUNC_GPIO	0
 #define RK_FUNC_1	1
 #define RK_FUNC_2	2
+#define RK_FUNC_3	3
+#define RK_FUNC_4	4
 
 #endif
-- 
2.0.0.526.g5318336
