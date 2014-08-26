From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 26 Aug 2014 16:10:27 +0200
Subject: [PATCH v3 4/5] ARM: dts: exynos4x12: Add utility macro to define pin
 sleep states
In-Reply-To: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
References: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
Message-ID: <1409062228-14690-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a convenient macro which constructs an Exynos pinctrl
pinconf node containing properties needed to configure sleep state of
given pin with given parameters. It will be used by further patch which
adds a large number of sleep states for pins that need such
configuration on certain boards.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 99b26df..927fec6 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -12,6 +12,22 @@
  * published by the Free Software Foundation.
 */
 
+#define PIN_PULL_NONE		0
+#define PIN_PULL_DOWN		1
+#define PIN_PULL_UP		3
+
+#define PIN_PDN_OUT0		0
+#define PIN_PDN_OUT1		1
+#define PIN_PDN_INPUT		2
+#define PIN_PDN_PREV		3
+
+#define PIN_SLP(_pin, _mode, _pull)				\
+	_pin {							\
+		samsung,pins = #_pin;				\
+		samsung,pin-con-pdn = <PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <PIN_PULL_ ##_pull>;	\
+	}
+
 / {
 	pinctrl at 11400000 {
 		gpa0: gpa0 {
-- 
2.0.4
