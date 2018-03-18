From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:38 +0100
Subject: [PATCH 3/7] ARM: multi_v7_defconfig: configure I2C driver built-in
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180318203442.19759-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMIC often require the I2C bus, and the PMIC regulators might be
necessary to power on eMMC/SD-card or other supplies required
for successful boot. Make sure I2C driver for i.MX devices is
built-in.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 608bc85856a1..fc142dc75092 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -368,7 +368,7 @@ CONFIG_I2C_DIGICOLOR=m
 CONFIG_I2C_EMEV2=m
 CONFIG_I2C_GPIO=m
 CONFIG_I2C_EXYNOS5=y
-CONFIG_I2C_IMX=m
+CONFIG_I2C_IMX=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_RK3X=y
-- 
2.16.2
