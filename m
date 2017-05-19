From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:09:23 +0200
Subject: [PATCH 4/6] gpio: mvebu: allow building driver for Armada 7K/8K
In-Reply-To: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
Message-ID: <ed816f275537bf4e0d4557ed53b685b4f3186605.1495210061.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu gpio driver can also be used on arm64 mvebu SoC such as the
Armada 7K/8K. This commit allows to build the driver for them (when only
ARCH_MVEBU is defined)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 23ca51ee6b28..418316b82bd2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -326,7 +326,7 @@ config GPIO_MPC8XXX
 
 config GPIO_MVEBU
 	def_bool y
-	depends on PLAT_ORION
+	depends on PLAT_ORION || ARCH_MVEBU
 	depends on OF_GPIO
 	select GENERIC_IRQ_CHIP
 
-- 
git-series 0.9.1
