From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Dec 2012 15:29:11 +0100
Subject: [PATCH] sunxi: Change the machine compatible string.
Message-ID: <1355840951-32533-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68136b10 ("ARM: sunxi: Change device tree naming scheme for
sunxi") changed the naming scheme and the compatible strings used in the
device trees related to the sunXi platform, but forgot to change the
compatible string in the DT machine definition.

This prevents the kernel from booting on these boards.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index dc634ae..d09e408 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -79,8 +79,8 @@ static void __init sunxi_dt_init(void)
 }
 
 static const char * const sunxi_board_dt_compat[] = {
-	"allwinner,sun4i",
-	"allwinner,sun5i",
+	"allwinner,sun4i-a10",
+	"allwinner,sun5i-a13",
 	NULL,
 };
 
-- 
1.7.9.5
