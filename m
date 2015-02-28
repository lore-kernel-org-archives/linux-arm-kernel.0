From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 27 Feb 2015 19:10:26 -0600
Subject: [PATCH 1/2] pinctrl: am33xx: dt-bindings: fix SLEWCTRL_FAST binding
In-Reply-To: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
References: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1425085827-4514-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to AM335x TRM, Document spruh73l, Revised February 2015,
Section 9.2.2 Pad Control Registers, setting bit 6 of the pad control
registers actually sets the SLEWCTRL value to slow rather than fast as
the current macro indicates. Introduce a new macro, SLEWCTRL_SLOW, that
sets the bit, and modify SLEWCTRL_FAST to 0 but keep it for
completeness.

Current users of the macro (i2c and mdio) are left unmodified as
SLEWCTRL_FAST was the macro used and actual desired state. Tested on
am335x-gp-evm with no difference in software performance seen.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/dt-bindings/pinctrl/am33xx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
index 2fbc804..226f772 100644
--- a/include/dt-bindings/pinctrl/am33xx.h
+++ b/include/dt-bindings/pinctrl/am33xx.h
@@ -13,7 +13,8 @@
 
 #define PULL_DISABLE		(1 << 3)
 #define INPUT_EN		(1 << 5)
-#define SLEWCTRL_FAST		(1 << 6)
+#define SLEWCTRL_SLOW		(1 << 6)
+#define SLEWCTRL_FAST		0
 
 /* update macro depending on INPUT_EN and PULL_ENA */
 #undef PIN_OUTPUT
-- 
2.3.0
