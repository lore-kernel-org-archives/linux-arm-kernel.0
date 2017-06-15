From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Jun 2017 17:06:27 +0200
Subject: [PATCH 1/2] pinctrl: samsung: dt-bindings: Use better name for
 external interrupt function
Message-ID: <20170615150628.26723-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos, 0xf is always used as value of external interrupt in pin mux
function thus a more descriptive macro name can be used.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/dt-bindings/pinctrl/samsung.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index b7aa3646208b..ceb672305f59 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -66,7 +66,8 @@
 #define EXYNOS_PIN_FUNC_4		4
 #define EXYNOS_PIN_FUNC_5		5
 #define EXYNOS_PIN_FUNC_6		6
-#define EXYNOS_PIN_FUNC_F		0xf
+#define EXYNOS_PIN_FUNC_EINT		0xf
+#define EXYNOS_PIN_FUNC_F		EXYNOS_PIN_FUNC_EINT
 
 /* Drive strengths for Exynos7 FSYS1 block */
 #define EXYNOS7_FSYS1_PIN_DRV_LV1	0
-- 
2.9.3
