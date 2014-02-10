From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 11:47:28 +0100
Subject: [PATCH 2/7] ARM: shmobile: lager legacy: Add QSPI pinmux
In-Reply-To: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1392029254-15400-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-lager.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 317574864e7b..9e52efa2a457 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -606,6 +606,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* I2C2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar.2", "pfc-r8a7790",
 				  "i2c2", "i2c2"),
+	/* QSPI */
+	PIN_MAP_MUX_GROUP_DEFAULT("qspi.0", "pfc-r8a7790",
+				  "qspi_ctrl", "qspi"),
+	PIN_MAP_MUX_GROUP_DEFAULT("qspi.0", "pfc-r8a7790",
+				  "qspi_data4", "qspi"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
-- 
1.7.9.5
