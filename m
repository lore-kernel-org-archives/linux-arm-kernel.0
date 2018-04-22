From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Apr 2018 12:38:04 +0200
Subject: [PATCH 1/2] arm: multi_v7_defconfig: enable the Amlogic Meson I2C
 driver
In-Reply-To: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
References: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180422103805.1324-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards come with a PMIC (system power controller, for example Ricoh
RN5T618) which is connected through I2C.
Enable the Meson I2C driver so the devices on the I2C bus can be
registered during boot.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96d4c09..19e60d562e5f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -364,6 +364,7 @@ CONFIG_HVC_DRIVER=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
+CONFIG_I2C_MESON=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=m
 CONFIG_I2C_MUX_PCA954x=y
-- 
2.17.0
