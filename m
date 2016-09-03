From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Sep 2016 17:13:00 -0700
Subject: [PATCH] arm64: defconfig: enable HW random as module
Message-ID: <20160903001301.32289-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/char/hw_random/Kconfig has 'default m', so
simply removing this entry from the defconfig will
enable building HW random drivers as modules.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0555b7caaf2c..4bc1af4ae162 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -176,7 +176,6 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_VIRTIO_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-- 
2.9.3
