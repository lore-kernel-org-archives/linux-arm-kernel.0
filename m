From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:28:03 -0700
Subject: [PATCH v2 13/14] ARM: tegra: cpu-tegra: sparse type fix
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-14-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Type fix:
arch/arm/mach-tegra/cpu-tegra.c:144:14: warning: incorrect type in argument 5 (different signedness)
arch/arm/mach-tegra/cpu-tegra.c:144:14:    expected unsigned int *index
arch/arm/mach-tegra/cpu-tegra.c:144:14:    got int *<noident>

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/cpu-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 0e1016a..f15b689 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -130,7 +130,7 @@ static int tegra_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	int idx;
+	unsigned int idx;
 	unsigned int freq;
 	int ret = 0;
 
-- 
1.7.4.1
