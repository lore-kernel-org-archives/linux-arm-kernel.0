From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 31 Jan 2012 18:40:43 +0200
Subject: [PATCH v2 5/8] ARM: tegra: export tegra_powergate_is_powered()
In-Reply-To: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1328028051-24271-6-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export tegra_powergate_is_powered(). This function will be used by the Tegra30
code to bringup secondary CPU cores.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/powergate.h |    1 +
 arch/arm/mach-tegra/powergate.c              |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/powergate.h b/arch/arm/mach-tegra/include/mach/powergate.h
index 36846dc..0ec8ce1 100644
--- a/arch/arm/mach-tegra/include/mach/powergate.h
+++ b/arch/arm/mach-tegra/include/mach/powergate.h
@@ -28,6 +28,7 @@
 #define TEGRA_POWERGATE_L2	5
 #define TEGRA_POWERGATE_MPE	6
 
+int tegra_powergate_is_powered(int id);
 int tegra_powergate_power_on(int id);
 int tegra_powergate_power_off(int id);
 int tegra_powergate_remove_clamping(int id);
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 9b828f2..984bbdf 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -93,7 +93,7 @@ int tegra_powergate_power_off(int id)
 	return tegra_powergate_set(id, false);
 }
 
-static int tegra_powergate_is_powered(int id)
+int tegra_powergate_is_powered(int id)
 {
 	u32 status;
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
