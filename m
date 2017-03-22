From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 22 Mar 2017 17:03:32 +0900
Subject: [PATCH 2/2] pinctrl: samsung: Remove unused pin-bank macro
In-Reply-To: <1490169812-25225-1-git-send-email-cw00.choi@samsung.com>
References: <1490169812-25225-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170322080335epcas5p2f514974da14bd739d712cf1ab1a4cc0c@epcas5p2.samsung.com>
Message-ID: <1490169812-25225-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After merged commit 1259feddd0f8 ("pinctrl: samsung: Fix the width
of PINCFG_TYPE_DRV bitfields for Exynos5433"), EXYNOS_PIN_BANK_EINTW
was replaced by EXYNOS5433_PIN_BANK_EINTW_EXT. This patch removes
the unused pin-bank macro (EXYNOS_PIN_BANK_EINTW).

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index a473092fb8d2..cd046eb7d705 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -79,17 +79,6 @@
 		.name		= id			\
 	}
 
-#define EXYNOS_PIN_BANK_EINTW_EXT(pins, reg, id, offs, pctl_idx) \
-	{						\
-		.type           = &bank_type_alive,	\
-		.pctl_offset    = reg,                  \
-		.nr_pins        = pins,                 \
-		.eint_type      = EINT_TYPE_WKUP,       \
-		.eint_offset    = offs,                 \
-		.name           = id,                   \
-		.pctl_res_idx   = pctl_idx,             \
-	}						\
-
 #define EXYNOS5433_PIN_BANK_EINTG(pins, reg, id, offs)		\
 	{							\
 		.type		= &exynos5433_bank_type_off,	\
-- 
1.9.1
