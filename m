From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Nov 2009 19:04:23 -0800
Subject: [PATCH 10/10] omap3: AM35xx: Initialize omap_chip bits
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Message-ID: <20091112030423.5159.96630.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ranjith Lohithakshan <ranjithl@ti.com>

AM35xx is functionally similar to OMAP3430 ES3.1 from a
powerdomain/clockdomain perspective. This patch initializes the
omap_chip bits on AM35xx for use by powerdomain and clockdomain code.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f8252c6..441ca26 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -372,6 +372,8 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap242x()) {
 		/* Currently only supports 2420ES2.1.1 and 2420-all */
 		omap_chip.oc |= CHIP_IS_OMAP2420;
+	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		omap_chip.oc = CHIP_IS_OMAP3430 | CHIP_IS_OMAP3430ES3_1;
 	} else if (cpu_is_omap343x()) {
 		omap_chip.oc = CHIP_IS_OMAP3430;
 		if (omap_rev() == OMAP3430_REV_ES1_0)
