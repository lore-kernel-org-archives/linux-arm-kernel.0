From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Sep 2009 16:36:45 -0700
Subject: [PATCH 04/12] omap: Add missing mux pin for EHCI phy reset line
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Message-ID: <20090924233645.6065.90549.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

GPIO135 is used as EHCI (port2) phy reset pin on Multi Media Daughter card
connected to OMAP3EVM.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c             |    2 ++
 arch/arm/plat-omap/include/mach/mux.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 2daa595..339ba80 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -472,6 +472,8 @@ MUX_CFG_34XX("G25_34XX_GPIO86_OUT", 0x0fc,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AG4_34XX_GPIO134_OUT", 0x160,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF4_34XX_GPIO135_OUT", 0x162,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AE4_34XX_GPIO136_OUT", 0x164,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 98dfab6..4bcf8a5 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -846,6 +846,7 @@ enum omap34xx_index {
 	L8_34XX_GPIO63,
 	G25_34XX_GPIO86_OUT,
 	AG4_34XX_GPIO134_OUT,
+	AF4_34XX_GPIO135_OUT,
 	AE4_34XX_GPIO136_OUT,
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
