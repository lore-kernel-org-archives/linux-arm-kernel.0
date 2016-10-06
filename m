From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 6 Oct 2016 11:33:33 +0200
Subject: [PATCH -next] serial: stm32: fix build failure
Message-ID: <1475746413-18301-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building m32r config the build failed with:
ERROR: stm32-usart.c:(.text+0xdc988): undefined reference to `bad_dma_ops'

To satisfy the dependency CONFIG_SERIAL_STM32 should depend on HAS_DMA.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c783140..8a261c0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1624,6 +1624,7 @@ config SERIAL_SPRD_CONSOLE
 
 config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
+	depends on HAS_DMA
 	select SERIAL_CORE
 	depends on ARM || COMPILE_TEST
 	help
-- 
1.9.1
