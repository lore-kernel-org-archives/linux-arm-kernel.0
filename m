From: sjur.brandeland@stericsson.com (Sjur Braendeland)
Date: Fri, 22 Oct 2010 21:03:55 +0200
Subject: [PATCH 4/4] caif-u5500: Build config for CAIF shared mem driver
In-Reply-To: <1287774235-11151-4-git-send-email-sjur.brandeland@stericsson.com>
References: <1287774235-11151-1-git-send-email-sjur.brandeland@stericsson.com>
	<1287774235-11151-2-git-send-email-sjur.brandeland@stericsson.com>
	<1287774235-11151-3-git-send-email-sjur.brandeland@stericsson.com>
	<1287774235-11151-4-git-send-email-sjur.brandeland@stericsson.com>
Message-ID: <1287774235-11151-5-git-send-email-sjur.brandeland@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amarnath Revanna <amarnath.bangalore.revanna@stericsson.com>

Signed-off-by: Sjur Braendeland <sjur.brandeland@stericsson.com>
---
 drivers/net/caif/Kconfig  |    7 +++++++
 drivers/net/caif/Makefile |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
index 75bfc3a..09ed3f4 100644
--- a/drivers/net/caif/Kconfig
+++ b/drivers/net/caif/Kconfig
@@ -31,3 +31,10 @@ config CAIF_SPI_SYNC
 	Putting the next command and length in the start of the frame can
 	help to synchronize to the next transfer in case of over or under-runs.
 	This option also needs to be enabled on the modem.
+
+config CAIF_SHM
+	tristate "CAIF shared memory protocol driver"
+	depends on CAIF && U5500_MBOX
+	default n
+	---help---
+	The CAIF shared memory protocol driver for the STE UX5500 platform.
diff --git a/drivers/net/caif/Makefile b/drivers/net/caif/Makefile
index 3a11d61..b38d987 100644
--- a/drivers/net/caif/Makefile
+++ b/drivers/net/caif/Makefile
@@ -8,3 +8,7 @@ obj-$(CONFIG_CAIF_TTY) += caif_serial.o
 # SPI slave physical interfaces module
 cfspi_slave-objs := caif_spi.o caif_spi_slave.o
 obj-$(CONFIG_CAIF_SPI_SLAVE) += cfspi_slave.o
+
+# Shared memory
+caif_shm-objs := caif_shmcore.o caif_shm_u5500.o
+obj-$(CONFIG_CAIF_SHM) += caif_shm.o
-- 
1.6.3.3
