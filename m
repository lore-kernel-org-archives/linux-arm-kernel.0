From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 20 Jun 2016 16:41:35 +0100
Subject: [PATCH] arm64: defconfig: enable Generic on-chip SRAM driver
Message-ID: <1466437295-30553-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the ARM SoCs have small SRAM memory used for various purposes
that require faster access to data compared to normal DDR.

This patch enables the Generic on-chip SRAM driver on ARM64.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d9e914aec081..bf0b0d258246 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -101,6 +101,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_SRAM=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
--
2.7.4
