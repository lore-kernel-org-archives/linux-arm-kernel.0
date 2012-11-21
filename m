From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:34 +0100
Subject: [PATCH 5/5] ARM: mvebu: update defconfig with I2C and RTC support
In-Reply-To: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353536675-15010-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for the I2C busses on Armada 370/XP, and
support for the RTC on the OpenBlocks AX3-4 platform, include the
necessary options in mvebu_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index cc2c3b2..73b53fc 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -31,9 +31,13 @@ CONFIG_MARVELL_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_I2C=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.7.9.5
