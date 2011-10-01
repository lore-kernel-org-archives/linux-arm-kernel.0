From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:55 +0200
Subject: [PATCH 23/26] ARM: pxa: viper: select I2C_GPIO only when I2C is on
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-24-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The viper platform selects the i2c_gpio driver, but that does
not build when i2c itself is disabled. Rather than also selecting
i2c, this makes the select conditional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index ef35ce9..568b7f6 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -81,7 +81,7 @@ config ARCH_VIPER
 	bool "Arcom/Eurotech VIPER SBC"
 	select PXA25x
 	select ISA
-	select I2C_GPIO
+	select I2C_GPIO if I2C
 	select HAVE_PWM
 	select PXA_HAVE_ISA_IRQS
 	select ARCOM_PCMCIA
-- 
1.7.5.4
