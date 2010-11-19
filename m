From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Nov 2010 21:58:32 +0100
Subject: [PATCH 00/51] some more imx patches for 2.6.38
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <20101119205832.GY8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Nov 17, 2010 at 10:28:21PM +0100, Uwe Kleine-K?nig wrote:
> Some of the patches in this series are already in Sascha's tree, I
> resend them because several of them got minor fixes.
I fixed a few things found by checkpatch.

In total the changes are:

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index f07d3d7..328e1af 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -105,7 +105,7 @@ static struct pad_desc mx25pdk_pads[] = {
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
-	.phy    = PHY_INTERFACE_MODE_RMII,
+        .phy    = PHY_INTERFACE_MODE_RMII,
 };
 
 #define FEC_ENABLE_GPIO		35
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index c61bd4e..e64d474 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -23,7 +23,7 @@ const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
 
 #ifdef CONFIG_SOC_IMX25
 const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX25, SZ_16K);
+        imx_imx2_wdt_data_entry_single(MX25, SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_rnga.c b/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
index b4b7612..7363ad7 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
@@ -42,7 +42,7 @@ static int __init imxXX_add_mxc_rnga(void)
 	struct platform_device *ret;
 
 #if defined(CONFIG_SOC_IMX31)
-	if (cpu_is_mx31())
+	if (cpu_is_mx31()) 
 		ret = imx_add_mxc_rnga(&imx31_mxc_rnga_data);
 	else
 #endif /* if defined(CONFIG_SOC_IMX31) */

I folded it in the introducing patches.  I think it's not worth to
resend the new patches, but I can do if you really want.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
