From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:34:01 +0100
Subject: [PATCH 16/18] arm: mvebu: enable SDIO support in mvebu_defconfig
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has gained Device Tree support and the
necessary Device Tree informations has been added for Armada 370 and
Armada XP platforms, we enable the MMC subsystem and the mvsdio driver
in mvebu_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index a702fb3..14cb45c 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -39,6 +39,8 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_MVSDIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5
