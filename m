From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Jun 2011 15:42:49 -0300
Subject: [PATCH 1/2] ARM: mach-imx/mx31ads: Fix section mismatches
Message-ID: <1308076970-2568-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following section mismatches:

WARNING: vmlinux.o(.text+0x101cc): Section mismatch in reference from the function mxc_init_i2c() to the (unknown reference) .init.data:(unknown)
The function mxc_init_i2c() references
the (unknown reference) __initdata (unknown).
This is often because mxc_init_i2c lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x101d8): Section mismatch in reference from the function mxc_init_i2c() to the variable .init.rodata:imx31_imx_i2c_data
The function mxc_init_i2c() references
the variable __initconst imx31_imx_i2c_data.
This is often because mxc_init_i2c lacks a __initconst 
annotation or the annotation of imx31_imx_i2c_data is wrong.

WARNING: vmlinux.o(.text+0x10200): Section mismatch in reference from the function mxc_init_audio() to the variable .init.rodata:imx31_imx_ssi_data
The function mxc_init_audio() references
the variable __initconst imx31_imx_ssi_data.
This is often because mxc_init_audio lacks a __initconst 
annotation or the annotation of imx31_imx_ssi_data is wrong.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31ads.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 0ce4947..29ca890 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -468,7 +468,7 @@ static struct i2c_board_info __initdata mx31ads_i2c1_devices[] = {
 #endif
 };
 
-static void mxc_init_i2c(void)
+static void __init mxc_init_i2c(void)
 {
 	i2c_register_board_info(1, mx31ads_i2c1_devices,
 				ARRAY_SIZE(mx31ads_i2c1_devices));
@@ -486,7 +486,7 @@ static unsigned int ssi_pins[] = {
 	MX31_PIN_STXD5__STXD5,
 };
 
-static void mxc_init_audio(void)
+static void __init mxc_init_audio(void)
 {
 	imx31_add_imx_ssi(0, NULL);
 	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
-- 
1.6.0.4
