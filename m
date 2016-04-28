From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Apr 2016 15:21:34 +0200
Subject: [PATCH 4/4] ARM: tegra: pm: Add tegra_cpu_do_idle() prototype
In-Reply-To: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
References: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461849694-13068-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

When building with W=1 this function is flagged as not having a
prototype defined. Add the prototype to avoid a build warning.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 83bc87583446..717b48f22912 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -36,7 +36,7 @@ void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
 bool tegra_set_cpu_in_lp2(void);
-
+int tegra_cpu_do_idle(void);
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
-- 
2.8.0
