From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:45 +0900
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable I2C demultiplexer and
 slave eeprom
In-Reply-To: <cover.1459732004.git.horms+renesas@verge.net.au>
References: <cover.1459732004.git.horms+renesas@verge.net.au>
Message-ID: <651435d68253b0a5059175e2f113528080e5928e.1459732004.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The Renesas Lager board shall be a reference platform for the runtime
I2C IP core switcher and for I2C slave support. Enable the needed
drivers for this.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 28234906a064..434f86b110bb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -322,6 +322,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=m
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
+CONFIG_I2C_DEMUX_PINCTRL=y
 CONFIG_I2C_AT91=m
 CONFIG_I2C_BCM2835=y
 CONFIG_I2C_CADENCE=y
@@ -345,6 +346,7 @@ CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_XILINX=y
 CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=m
+CONFIG_I2C_SLAVE_EEPROM=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=m
 CONFIG_SPI_BCM2835=y
-- 
2.1.4
