From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Jun 2011 15:42:50 -0300
Subject: [PATCH 2/2] ARM: mach-imx/mx31lilly: Fix section mismatches
In-Reply-To: <1308076970-2568-1-git-send-email-fabio.estevam@freescale.com>
References: <1308076970-2568-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308076970-2568-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following section mismatches:

WARNING: vmlinux.o(.text+0x1026c): Section mismatch in reference from the function lilly1131_usb_init() to the variable .init.rodata:imx31_mxc_ehci_hs_data
The function lilly1131_usb_init() references
the variable __initconst imx31_mxc_ehci_hs_data.
This is often because lilly1131_usb_init lacks a __initconst 
annotation or the annotation of imx31_mxc_ehci_hs_data is wrong.

WARNING: vmlinux.o(.text+0x10270): Section mismatch in reference from the function lilly1131_usb_init() to the (unknown reference) .init.rodata:(unknown)
The function lilly1131_usb_init() references
the (unknown reference) __initconst (unknown).
This is often because lilly1131_usb_init lacks a __initconst 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x10274): Section mismatch in reference from the function lilly1131_usb_init() to the (unknown reference) .init.data:(unknown)
The function lilly1131_usb_init() references
the (unknown reference) __initdata (unknown).
This is often because lilly1131_usb_init lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31lilly.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 750368d..126913a 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -192,7 +192,7 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 };
 
-static void lilly1131_usb_init(void)
+static void __init lilly1131_usb_init(void)
 {
 	imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
 
-- 
1.6.0.4
