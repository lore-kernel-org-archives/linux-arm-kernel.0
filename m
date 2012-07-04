From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 03:06:41 -0600 (MDT)
Subject: [PATCH] ARM: OMAP4: hwmod data: temporarily remove data for the
 usb_host_fs and aess IP blocks
In-Reply-To: <4FF2A5CC.80400@ti.com>
References: <alpine.DEB.2.00.1206292151290.2338@utopia.booyaka.com>
 <4FF2A5CC.80400@ti.com>
Message-ID: <alpine.DEB.2.00.1207040303240.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2012, Benoit Cousson wrote:

> On 06/30/2012 05:53 AM, Paul Walmsley wrote:
> 
> > The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
> > programming for them to enter idle.  Without this programming, they
> > will prevent the rest of the chip from entering full chip idle.
> > 
> > To implement the idle programming cleanly, this will take some
> > coordination between maintainers.  This is likely to take some time,
> > so it is probably best to leave this for 3.6 or 3.7.  So, in the
> > meantime, simply remove this data.
> 
> I'd rather keep the data and comment the ocp_if entry.
> We can even add a disclaimer on top to explain the reason.
> 
> It will be less confusing for the driver folks that are currently working on
> the AESS support.
> 
> It will as well minimize the churn.

Well I'm not a big fan of adding __maybe_unused to this data, but I guess
changing the approach doesn't matter that much to me.  Updated patch 
below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 29 Jun 2012 17:10:41 -0600
Subject: [PATCH] ARM: OMAP4: hwmod data: temporarily comment out data for the
 usb_host_fs and aess IP blocks

The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
programming for them to enter idle.  Without this programming, they
will prevent the rest of the chip from entering full chip idle.

To implement the idle programming cleanly, this will take some
coordination between maintainers.  This is likely to take some time,
so it is probably best to leave this for 3.6 or 3.7.  So, in the
meantime, prevent these IP blocks from being registered.

Later, once the appropriate support is available, this patch can be
reverted.

This second version comments out the IP block data since Beno?t didn't
like removing it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f30e861..0a1b247 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3864,7 +3864,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 };
 
 /* usb_host_fs -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_usb_host_fs__l3_main_2 = {
 	.master		= &omap44xx_usb_host_fs_hwmod,
 	.slave		= &omap44xx_l3_main_2_hwmod,
 	.clk		= "l3_div_ck",
@@ -3922,7 +3922,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_3 = {
 };
 
 /* aess -> l4_abe */
-static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_aess__l4_abe = {
 	.master		= &omap44xx_aess_hwmod,
 	.slave		= &omap44xx_l4_abe_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -4013,7 +4013,7 @@ static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
 };
 
 /* l4_abe -> aess */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -4031,7 +4031,7 @@ static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
 };
 
 /* l4_abe -> aess (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess_dma = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
@@ -5857,7 +5857,7 @@ static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] = {
 };
 
 /* l4_cfg -> usb_host_fs */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs = {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_cfg__usb_host_fs = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_usb_host_fs_hwmod,
 	.clk		= "l4_div_ck",
@@ -6014,13 +6014,13 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_iva__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
-	&omap44xx_usb_host_fs__l3_main_2,
+	/* &omap44xx_usb_host_fs__l3_main_2, */
 	&omap44xx_usb_host_hs__l3_main_2,
 	&omap44xx_usb_otg_hs__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_3,
 	&omap44xx_l3_main_2__l3_main_3,
 	&omap44xx_l4_cfg__l3_main_3,
-	&omap44xx_aess__l4_abe,
+	/* &omap44xx_aess__l4_abe, */
 	&omap44xx_dsp__l4_abe,
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
@@ -6029,8 +6029,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__l4_wkup,
 	&omap44xx_mpu__mpu_private,
 	&omap44xx_l4_cfg__ocp_wp_noc,
-	&omap44xx_l4_abe__aess,
-	&omap44xx_l4_abe__aess_dma,
+	/* &omap44xx_l4_abe__aess, */
+	/* &omap44xx_l4_abe__aess_dma, */
 	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
 	&omap44xx_l4_cfg__ctrl_module_core,
@@ -6136,7 +6136,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__uart2,
 	&omap44xx_l4_per__uart3,
 	&omap44xx_l4_per__uart4,
-	&omap44xx_l4_cfg__usb_host_fs,
+	/* &omap44xx_l4_cfg__usb_host_fs, */
 	&omap44xx_l4_cfg__usb_host_hs,
 	&omap44xx_l4_cfg__usb_otg_hs,
 	&omap44xx_l4_cfg__usb_tll_hs,
-- 
1.7.10
