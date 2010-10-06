From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Oct 2010 12:00:19 +0200
Subject: [PATCH 3/3] ARM: mx3/cpuimx35: mark otg_pdata and usbh1_pdata as
	maybe unused
In-Reply-To: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1286359219-5869-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes

	arch/arm/mach-mx3/mach-cpuimx35.c:143: warning: 'otg_pdata' defined but not used
	arch/arm/mach-mx3/mach-cpuimx35.c:148: warning: 'usbh1_pdata' defined but not used

when USB_ULPI is not selected.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-cpuimx35.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index fb4d140..16916c9 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -140,12 +140,12 @@ eukrea_cpuimx35_nand_board_info __initconst = {
 	.flash_bbt	= 1,
 };
 
-static struct mxc_usbh_platform_data otg_pdata = {
+static struct mxc_usbh_platform_data __maybe_unused otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
-static struct mxc_usbh_platform_data usbh1_pdata = {
+static struct mxc_usbh_platform_data __maybe_unused usbh1_pdata = {
 	.portsc	= MXC_EHCI_MODE_SERIAL,
 	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
 		  MXC_EHCI_IPPUE_DOWN,
-- 
1.7.2.3
