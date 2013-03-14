From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 12:53:23 +0100
Subject: [PATCH] ARM: i.MX25: Fix DT compilation
Message-ID: <1363262003-4263-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX25 DT machine descriptor calls a non existing imx25_timer_init()
function. This patch adds it to fix compilation.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/imx25-dt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index 03b65e5e..8234839 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -27,6 +27,11 @@ static const char * const imx25_dt_board_compat[] __initconst = {
 	NULL
 };
 
+static void __init imx25_timer_init(void)
+{
+	mx25_clocks_init_dt();
+}
+
 DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
-- 
1.8.2.rc2
