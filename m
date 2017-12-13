From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 13 Dec 2017 15:24:43 -0600
Subject: [PATCH] ARM: dts: am43xx: Fix inverted DS0_PULL_UP_DOWN_EN macro
Message-ID: <20171213212443.22632-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a mistake in documentation the DS0_PULL_UP_DOWN_EN macro was
mistakenly defined as an active high bit, however setting the bit
actually disables the internal pull resistor on the pin, so correct this
macro and introduce a new DS0_PULL_UP_DOWN_DIS macro with the proper bit
value set now that the documentation has been updated.

Change based on AM437x Techninal Reference Manual SPRUHL7G Revised June
2017 Section 7.2.1.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/dt-bindings/pinctrl/am43xx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index a69e310789c5..6ce4a32f77d4 100644
--- a/include/dt-bindings/pinctrl/am43xx.h
+++ b/include/dt-bindings/pinctrl/am43xx.h
@@ -25,7 +25,8 @@
 #define DS0_FORCE_OFF_MODE	(1 << 24)
 #define DS0_INPUT		(1 << 25)
 #define DS0_FORCE_OUT_HIGH	(1 << 26)
-#define DS0_PULL_UP_DOWN_EN	(1 << 27)
+#define DS0_PULL_UP_DOWN_EN	(0 << 27)
+#define DS0_PULL_UP_DOWN_DIS	(1 << 27)
 #define DS0_PULL_UP_SEL		(1 << 28)
 #define WAKEUP_ENABLE		(1 << 29)
 
-- 
2.15.1
