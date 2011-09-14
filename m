From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 14 Sep 2011 14:04:38 -0300
Subject: [PATCH] ARM: mx31pdk: Fix build by passing IMX_HAVE_PLATFORM_MXC_MMC
Message-ID: <1316019878-15996-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx31pdk target fails to build:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-imx/built-in.o: In function `mx31_3ds_init':
mach-mx31_3ds.c:(.init.text+0x548): undefined reference to `imx_add_mxc_mmc'
mach-mx31_3ds.c:(.init.text+0x69c): undefined reference to `imx31_mxc_mmc_data'
make: *** [.tmp_vmlinux1] Error

Fix this by passsing IMX_HAVE_PLATFORM_MXC_MMC option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..e9c2968 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -449,6 +449,7 @@ config MACH_MX31_3DS
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
-- 
1.7.1
