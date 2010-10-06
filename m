From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Wed,  6 Oct 2010 10:53:49 +0200
Subject: [PATCH for 2.6.36 1/2] cpuimx27: fix compile when ULPI is selected
Message-ID: <1286355230-15530-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this patch we get :
arch/arm/mach-imx/built-in.o: In function `eukrea_cpuimx27_init':
eukrea_mbimx27-baseboard.c:(.init.text+0x44c): undefined reference to `mxc_ulpi_access_ops'

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5c0369..6348017 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -122,6 +122,8 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
-- 
1.7.0.4
