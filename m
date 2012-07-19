From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Jul 2012 16:26:29 +0300
Subject: [PATCHv7 09/12] ARM: OMAP4: hwmod data: temporarily comment out data
 for the sl2if IP block
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Message-ID: <1342704392-23657-10-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP4 sl2if IP block requires some special programming for it to
enter idle. Without this programming, they will prevent the rest of
the chip from entering full chip idle.

This patch comments out the IP block data.

Later, once the appropriate support is available, this patch can be
reverted.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ad7df4e..8b60377 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4266,7 +4266,7 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iva = {
 };
 
 /* dsp -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_dsp__sl2if = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_dsp__sl2if = {
 	.master		= &omap44xx_dsp_hwmod,
 	.slave		= &omap44xx_sl2if_hwmod,
 	.clk		= "dpll_iva_m5x2_ck",
@@ -4884,7 +4884,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss = {
 };
 
 /* iva -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_iva__sl2if = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_iva__sl2if = {
 	.master		= &omap44xx_iva_hwmod,
 	.slave		= &omap44xx_sl2if_hwmod,
 	.clk		= "dpll_iva_m5x2_ck",
@@ -5418,7 +5418,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__scrm = {
 };
 
 /* l3_main_2 -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l3_main_2__sl2if = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_sl2if_hwmod,
 	.clk		= "l3_div_ck",
@@ -6088,7 +6088,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
 	&omap44xx_dsp__iva,
-	&omap44xx_dsp__sl2if,
+	/* &omap44xx_dsp__sl2if, */
 	&omap44xx_l4_cfg__dsp,
 	&omap44xx_l3_main_2__dss,
 	&omap44xx_l4_per__dss,
@@ -6124,7 +6124,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
-	&omap44xx_iva__sl2if,
+	/* &omap44xx_iva__sl2if, */
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
@@ -6155,7 +6155,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__cm_core,
 	&omap44xx_l4_wkup__prm,
 	&omap44xx_l4_wkup__scrm,
-	&omap44xx_l3_main_2__sl2if,
+	/* &omap44xx_l3_main_2__sl2if, */
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
 	&omap44xx_l4_per__slimbus2,
-- 
1.7.4.1
