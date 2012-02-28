From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 28 Feb 2012 04:10:56 -0700
Subject: [PATCH 8/9] ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Message-ID: <20120228111056.808.12836.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some hwmods were commented out from the OMAP4 data, under the theory
that they shouldn't be added until drivers were ready.  But part of
the utility of the hwmod code is that it can reset and properly
initialize IP blocks that have no drivers associated with them.
Rather than commenting the links in the future hwmod data conversion
patches, discussing this with Benoit, it seems best to simply
uncomment them now.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f3fd64d..4190385 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5408,10 +5408,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_mpu_private_hwmod,
 
 	/* aess class */
-/*	&omap44xx_aess_hwmod, */
+	&omap44xx_aess_hwmod,
 
 	/* counter class */
-/*	&omap44xx_counter_32k_hwmod, */
+	&omap44xx_counter_32k_hwmod,
 
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
@@ -5440,7 +5440,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio6_hwmod,
 
 	/* hsi class */
-/*	&omap44xx_hsi_hwmod, */
+	&omap44xx_hsi_hwmod,
 
 	/* i2c class */
 	&omap44xx_i2c1_hwmod,
@@ -5452,7 +5452,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_ipu_hwmod,
 
 	/* iss class */
-/*	&omap44xx_iss_hwmod, */
+	&omap44xx_iss_hwmod,
 
 	/* iva class */
 	&omap44xx_iva_hwmod,
