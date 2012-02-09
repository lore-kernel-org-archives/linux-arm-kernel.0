From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 10 Feb 2012 01:47:48 +0200
Subject: [PATCH v3 08/10] ARM: tegra: add support for Tegra30 powerdomains
In-Reply-To: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1328831277-21002-9-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new powerdomains in Tegra30 such as extra CPU cores and
the SATA domain.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/powergate.h |   10 ++++++++++
 arch/arm/mach-tegra/powergate.c              |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/powergate.h b/arch/arm/mach-tegra/include/mach/powergate.h
index 0ec8ce1..ca41186 100644
--- a/arch/arm/mach-tegra/include/mach/powergate.h
+++ b/arch/arm/mach-tegra/include/mach/powergate.h
@@ -27,6 +27,16 @@
 #define TEGRA_POWERGATE_VDEC	4
 #define TEGRA_POWERGATE_L2	5
 #define TEGRA_POWERGATE_MPE	6
+#define TEGRA_POWERGATE_HEG	7
+#define TEGRA_POWERGATE_SATA	8
+#define TEGRA_POWERGATE_CPU1	9
+#define TEGRA_POWERGATE_CPU2	10
+#define TEGRA_POWERGATE_CPU3	11
+#define TEGRA_POWERGATE_CELP	12
+#define TEGRA_POWERGATE_3D1	13
+
+#define TEGRA_POWERGATE_CPU0	TEGRA_POWERGATE_CPU
+#define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
 int tegra_powergate_is_powered(int id);
 int tegra_powergate_power_on(int id);
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 984bbdf..7120ad7 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -167,6 +167,9 @@ int __init tegra_powergate_init(void)
 	case TEGRA20:
 		tegra_num_powerdomains = 7;
 		break;
+	case TEGRA30:
+		tegra_num_powerdomains = 14;
+		break;
 	default:
 		/* Unknown Tegra variant. Disable powergating */
 		tegra_num_powerdomains = 0;
-- 
1.7.4.1
