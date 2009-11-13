From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Nov 2009 16:09:32 -0800
Subject: [PATCH 12/14] omap3: move check_revision above check_features
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Message-ID: <20091113000932.9034.66321.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tony Lindgren <Menon>

omap3_check_revision() does not depend on omap3_check_features()
move this above so that we can add logic based on revision
detected in check_features.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 441ca26..6c11b41 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -352,8 +352,8 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx())
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx()) {
-		omap3_check_features();
 		omap3_check_revision();
+		omap3_check_features();
 		omap3_cpuinfo();
 	}
 	else if (cpu_is_omap44xx()) {
