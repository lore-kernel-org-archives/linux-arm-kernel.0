From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 08:51:52 -0500
Subject: [PATCH 5/6] ARM: OMAP4+: PRM: Enable wakeup capability for OMAP5, DRA7
In-Reply-To: <1408715513-25851-1-git-send-email-nm@ti.com>
References: <1408715513-25851-1-git-send-email-nm@ti.com>
Message-ID: <1408715513-25851-6-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 and DRA7 can now use pinctrl based I/O daisychain wakeup
capability. So, enable the support.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index b6bfa6f..0958d07 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -693,7 +693,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
 	return prm_register(&omap44xx_prm_ll_data);
-- 
1.7.9.5
