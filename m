From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 Jun 2012 00:16:08 -0600
Subject: [PATCHv3 4/7] ARM: OMAP4: hwmod data: fix 32k sync timer idle modes
In-Reply-To: <20120618061037.30632.28539.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
Message-ID: <20120618061605.30632.31634.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32k sync timer IP block target idle modes in the hwmod data are
incorrect.  The IP block does not support any smart-idle modes.
Update the data to reflect the correct modes.

This problem was initially identified and a diff fragment posted to
the lists by Beno?t Cousson <b-cousson@ti.com>.  A patch description
bug in the first version was also identified by Beno?t.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4aaaa84..6b0aedc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -393,8 +393,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_counter_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
