From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Dec 2011 09:33:38 -0800
Subject: [PATCH] arm/tegra: remove __initdata annotation from pinmux tables
Message-ID: <1324402418-20279-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of reshuffling what functions in the pinmux paths should be
__init and thus could keep references to __initdata, let's just remove
the annotations for now -- the tables are moving to device tree in the
next version anyway and the whole subsystem is being wired up. We will
go back and re-annotate where appropriate once things settle down.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |    8 ++++----
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index af28fd3..a448f29 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -37,11 +37,11 @@
 		.slew_falling = TEGRA_SLEW_SLOWEST,		\
 	}
 
-static __initdata struct tegra_drive_pingroup_config seaboard_drive_pinmux[] = {
+static struct tegra_drive_pingroup_config seaboard_drive_pinmux[] = {
 	DEFAULT_DRIVE(SDIO1),
 };
 
-static __initdata struct tegra_pingroup_config common_pinmux[] = {
+static struct tegra_pingroup_config common_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -147,7 +147,7 @@ static __initdata struct tegra_pingroup_config common_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
+static struct tegra_pingroup_config seaboard_pinmux[] = {
 	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -163,7 +163,7 @@ static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
 	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 };
 
-static __initdata struct tegra_pingroup_config ventana_pinmux[] = {
+static struct tegra_pingroup_config ventana_pinmux[] = {
 	{TEGRA_PINGROUP_DDC,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_GMD,  TEGRA_MUX_SFLASH,   TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_LPW0, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index be2f3e8..1b3ccec 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -24,7 +24,7 @@
 #include "board-pinmux.h"
 #include "board-trimslice.h"
 
-static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
+static struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,	TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
-- 
1.7.5.4
