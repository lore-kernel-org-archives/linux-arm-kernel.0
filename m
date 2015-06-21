From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 21 Jun 2015 17:44:39 +0800
Subject: [PATCH 2/2] ARM: rockchip: remove some useless macro in pm.h
In-Reply-To: <1434879879-25162-1-git-send-email-zyw@rock-chips.com>
References: <1434879879-25162-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1434879879-25162-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are actually not used in the pm code, as we moved suspend handling
to the clock driver, remove them here.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 arch/arm/mach-rockchip/pm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
index 3e8d39c..b6494c2 100644
--- a/arch/arm/mach-rockchip/pm.h
+++ b/arch/arm/mach-rockchip/pm.h
@@ -59,13 +59,6 @@ static inline void rockchip_suspend_init(void)
 #define SGRF_DAPDEVICEEN		BIT(0)
 #define SGRF_DAPDEVICEEN_WRITE		BIT(16)
 
-#define RK3288_CRU_MODE_CON		0x50
-#define RK3288_CRU_SEL0_CON		0x60
-#define RK3288_CRU_SEL1_CON		0x64
-#define RK3288_CRU_SEL10_CON		0x88
-#define RK3288_CRU_SEL33_CON		0xe4
-#define RK3288_CRU_SEL37_CON		0xf4
-
 /* PMU_WAKEUP_CFG1 bits */
 #define PMU_ARMINT_WAKEUP_EN		BIT(0)
 
-- 
1.9.1
