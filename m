From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:24:57 +0100
Subject: [PATCH 04/14] mfd: Remove redundant Kconfig entry
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During ab8500-core clean-up the Kconfig entry for AB8500_I2C_CORE
was left remnant. This patch simply removes it.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e129c82..170072e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -703,16 +703,6 @@ config AB8500_CORE
 	  the irq_chip parts for handling the Mixed Signal chip events.
 	  This chip embeds various other multimedia funtionalities as well.
 
-config AB8500_I2C_CORE
-	bool "AB8500 register access via PRCMU I2C"
-	depends on AB8500_CORE && MFD_DB8500_PRCMU
-	default y
-	help
-	  This enables register access to the AB8500 chip via PRCMU I2C.
-	  The AB8500 chip can be accessed via SPI or I2C. On DB8500 hardware
-	  the I2C bus is connected to the Power Reset
-	  and Mangagement Unit, PRCMU.
-
 config AB8500_DEBUG
        bool "Enable debug info via debugfs"
        depends on AB8500_CORE && DEBUG_FS
-- 
1.7.9.5
