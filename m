From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 02 Oct 2012 11:24:04 +0200
Subject: [PATCH v2 2/4] ARM: EXYNOS: pm_domain: Fix power domain name
 initialization
In-Reply-To: <1349169846-30385-1-git-send-email-t.figa@samsung.com>
References: <1349169846-30385-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349169846-30385-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initialization of name field in generic power domain
struct.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index d1abc1a..5b7ce7e 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -98,7 +98,8 @@ static __init int exynos_pm_dt_parse_domains(void)
 			return -ENOMEM;
 		}
 
-		pd->name = np->name;
+		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
+		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
-- 
1.7.12
