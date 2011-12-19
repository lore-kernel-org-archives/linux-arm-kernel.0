From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 11:01:58 -0700
Subject: [PATCH 2/2] arm/tegra: Fix section mismatch errors in tegra30 pinmux
In-Reply-To: <1324317718-24464-1-git-send-email-swarren@nvidia.com>
References: <1324317718-24464-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324317718-24464-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra30_pinmux_init() is called from the pinmux's probe() function, and
hence should be __devinit not __init.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/pinmux-tegra30-tables.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/pinmux-tegra30-tables.c b/arch/arm/mach-tegra/pinmux-tegra30-tables.c
index 8b6db9a..14fc0e4 100644
--- a/arch/arm/mach-tegra/pinmux-tegra30-tables.c
+++ b/arch/arm/mach-tegra/pinmux-tegra30-tables.c
@@ -364,7 +364,7 @@ static const struct tegra_pingroup_desc tegra_soc_pingroups[TEGRA_MAX_PINGROUP]
 	PINGROUP(HDMI_CEC,	  SYS,      CEC,	RSVD1,	    RSVD2,	RSVD3,	    RSVD,	INPUT,	0x33e0),
 };
 
-void __init tegra30_pinmux_init(const struct tegra_pingroup_desc **pg,
+void __devinit tegra30_pinmux_init(const struct tegra_pingroup_desc **pg,
 		int *pg_max, const struct tegra_drive_pingroup_desc **pgdrive,
 		int *pgdrive_max)
 {
-- 
1.7.0.4
