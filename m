From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 30 Jun 2014 11:37:48 +0200
Subject: [PATCH] ARM: imx53: mark imx53_dt_board_compat as const
Message-ID: <1404121068-12275-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise GCC will mark the .init.rodata section
R/W, which causes a compile error once we add other
real R/O data, which happens with patch
"ARM: imx53: globally disable supervisor protect".

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index d757d8cbebd1..c3a404ce39e6 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -45,7 +45,7 @@ static void __init imx53_dt_init(void)
 	}
 }
 
-static const char *imx53_dt_board_compat[] __initconst = {
+static const char * const imx53_dt_board_compat[] __initconst = {
 	"fsl,imx53",
 	NULL
 };
-- 
2.0.0
