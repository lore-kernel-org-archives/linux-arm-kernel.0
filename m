From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:28 -0700
Subject: [PATCH 5/9] arm/tegra: Remove useless entries from ventana_pinmux[]
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-6-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the entries in ventana_pinmux[] are identical to what's already in
seaboard_pinmux[]. Remove the overrides from the Ventana table.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index cb5b2e9..19b2c20 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -161,12 +161,7 @@ static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
 };
 
 static __initdata struct tegra_pingroup_config ventana_pinmux[] = {
-	{TEGRA_PINGROUP_DAP3, TEGRA_MUX_DAP3,     TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DDC,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTB,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTC,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTD,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_GMD,  TEGRA_MUX_SFLASH,   TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_LPW0, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_LPW2, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-- 
1.7.0.4
