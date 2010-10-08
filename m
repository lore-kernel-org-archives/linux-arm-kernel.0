From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri,  8 Oct 2010 10:37:40 +0200
Subject: [PATCH v2 for 2.6.36 1/2] cpuimx27: fix compile when ULPI is selected
Message-ID: <1286527061-3013-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this patch we get :
arch/arm/mach-imx/built-in.o: In function `eukrea_cpuimx27_init':
eukrea_mbimx27-baseboard.c:(.init.text+0x44c): undefined reference to `mxc_ulpi_access_ops'

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : remove SPI's select which leaked in previous patch
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5c0369..2f7e272 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -122,6 +122,7 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
-- 
1.7.0.4
