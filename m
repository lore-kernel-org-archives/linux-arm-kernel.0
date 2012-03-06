From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue,  6 Mar 2012 12:45:42 +0400
Subject: [PATCH/RFC 1/2] arm/tegra: fix harmony pinmux for PCIe
In-Reply-To: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1331023544-6439-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6e96aca397 (arm/tegra: Harmony PCIe: Don't touch pinmux)
removed runtime tri-state toggling for PCIe related pinmux groups,
but it seems that the fact that all of them are tri-state by default
has been overlooked. Change defaults for these groups to TEGRA_TRI_NORMAL.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-tegra/board-harmony-pinmux.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 465808c..1af85bccc 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -53,7 +53,7 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
@@ -112,10 +112,10 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-- 
1.7.5.1.300.gc565c
