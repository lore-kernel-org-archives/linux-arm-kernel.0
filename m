From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 18 Oct 2012 12:20:07 +0300
Subject: [PATCHv9 5/8] ARM: OMAP4: PM: put all domains to OSWR during suspend
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Message-ID: <1350552010-28760-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
state that saves more power, but has higher latencies also. As suspend
is considered a high-latency operation, OSWR is appropriate here.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index a313165..d36e4e5 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -100,7 +100,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
+	pwrst->next_state = PWRDM_FUNC_PWRST_OSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1
