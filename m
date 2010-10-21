From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 00:23:45 +0800
Subject: [PATCH 2/2] mx25_3ds: add mmc support
In-Reply-To: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
References: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <1287678225-11066-3-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update mx25_3ds board support to register esdhc device

Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
---
 arch/arm/mach-mx25/Kconfig         |    1 +
 arch/arm/mach-mx25/mach-mx25_3ds.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index aa57e35..38ca09a 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -6,6 +6,7 @@ config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_ESDHC
 
 config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index bd18056..d3d8322 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -96,6 +96,14 @@ static struct pad_desc mx25pdk_pads[] = {
 	MX25_PAD_KPP_COL1__KPP_COL1,
 	MX25_PAD_KPP_COL2__KPP_COL2,
 	MX25_PAD_KPP_COL3__KPP_COL3,
+
+	/* SD1 */
+	MX25_PAD_SD1_CMD__SD1_CMD,
+	MX25_PAD_SD1_CLK__SD1_CLK,
+	MX25_PAD_SD1_DATA0__SD1_DATA0,
+	MX25_PAD_SD1_DATA1__SD1_DATA1,
+	MX25_PAD_SD1_DATA2__SD1_DATA2,
+	MX25_PAD_SD1_DATA3__SD1_DATA3,
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
@@ -193,6 +201,8 @@ static void __init mx25pdk_init(void)
 	mx25pdk_fec_reset();
 	imx25_add_fec(&mx25_fec_pdata);
 	mxc_register_device(&mx25_kpp_device, &mx25pdk_keymap_data);
+
+	imx25_add_esdhc(0, NULL);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.1
