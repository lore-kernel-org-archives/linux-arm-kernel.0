From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Aug 2010 11:01:46 +0300
Subject: [PATCH 1/6] omap3: id: fix 3630 rev detection
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Message-ID: <20100813080146.18750.38591.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Wrong placement of break causes all revisions of 3630 to be
detected as 3630 es1.2, we need to break main loop if we have
an identified chip, default falls through as in the rest of the
switches in this function.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Manjunath K <manjugk@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e8256a2..9a879f9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -284,8 +284,8 @@ static void __init omap3_check_revision(void)
 		default:
 			omap_revision =  OMAP3630_REV_ES1_2;
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
-			break;
 		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision =  OMAP3630_REV_ES1_2;
