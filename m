From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Jan 2013 15:57:59 +0100
Subject: [PATCH 3.8-rc] arm: mvebu: i2c come back in defconfig
In-Reply-To: <1358953079-1277-1-git-send-email-gregory.clement@free-electrons.com>
References: <1358953079-1277-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1358953079-1277-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the patch "arm: mvebu: Use dw-apb-uart instead of ns16650 as UART
driver" was applied to a git tree and became the commit b24212fbfba25
it wrongly removed the i2c support. This patch reintroduce it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index b5bc96c..cbd91bc 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -33,6 +33,8 @@ CONFIG_MVNETA=y
 CONFIG_MARVELL_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
-- 
1.7.9.5
