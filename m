From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:53:43 +0200
Subject: [PATCH 10/12] [v2] ARM: s3c24xx: make H1940BT depend on RFKILL
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720155410.3251043-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bluetooth is only supported when network support is part of the kernel,
so it is a bit pointless to build the hi1940-bt support without networking.
If we try anyway, we get a Kconfig warning:

warning: (TOSA_BT && H1940BT) selects RFKILL which has unmet direct dependencies (NET)

This turns the 'select' into 'depends on' as Krzysztof suggested when
I first sent a fix.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://patchwork.kernel.org/patch/8164161/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v1 was sent in Jan 2016, and instead added a dependency on CONFIG_NET
---
 arch/arm/mach-s3c24xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 648c519c7593..7da0165334ae 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -237,7 +237,7 @@ config ARCH_H1940
 config H1940BT
 	tristate "Control the state of H1940 bluetooth chip"
 	depends on ARCH_H1940
-	select RFKILL
+	depends on RFKILL
 	help
 	  This is a simple driver that is able to control
 	  the state of built in bluetooth chip on h1940.
-- 
2.9.0
