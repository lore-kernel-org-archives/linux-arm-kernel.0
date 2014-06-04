From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 4 Jun 2014 14:32:36 +0300
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This symbol needs to be exported to power on rails without using
tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
cannot be used in situations where the driver wants to handle clocking
by itself.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mach-tegra/powergate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 50a9af4..254c42e 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -125,6 +125,7 @@ int tegra_powergate_power_on(int id)
 
 	return tegra_powergate_set(id, true);
 }
+EXPORT_SYMBOL(tegra_powergate_power_on);
 
 int tegra_powergate_power_off(int id)
 {
-- 
1.8.1.5
