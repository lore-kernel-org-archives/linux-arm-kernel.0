From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:46 +0900
Subject: [PATCH 2/2] ARM: shmobile: defconfig: enable I2C demultiplexer and
 slave eeprom
In-Reply-To: <cover.1459732004.git.horms+renesas@verge.net.au>
References: <cover.1459732004.git.horms+renesas@verge.net.au>
Message-ID: <352486b164ad41f2536f77d568ada7d729d080c2.1459732004.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The Lager board shall be the reference platform for the runtime I2C IP
core switcher and for I2C slave support. Enable the needed drivers for
this.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b7b714c3958c..e06acb9b38ce 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -99,11 +99,14 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_DEMUX_PINCTRL=y
 CONFIG_I2C_EMEV2=y
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
+CONFIG_I2C_SLAVE_EEPROM=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_SH_MSIOF=y
-- 
2.1.4
