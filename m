From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 02:27:31 +0200
Subject: [GIT PULL] U300 multiplatform for v3.11
In-Reply-To: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
References: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
Message-ID: <201306200227.31603.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I needed this patch on top.

>From e0a60445624107912e4684e20e5e9158b94b4c87 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Jun 2013 02:26:37 +0200
Subject: [PATCH] ARM: u300: only build for ARCH_MULTI_V5

This avoids impossible platform combinations, as we cannot
build a combined V5 + V6/V7 kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 09f4dda..a85adcd 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -3,7 +3,7 @@ menu "ST-Ericsson AB U300/U335 Platform"
 comment "ST-Ericsson Mobile Platform Products"
 
 config ARCH_U300
-	bool "ST-Ericsson U300 Series"
+	bool "ST-Ericsson U300 Series" if ARCH_MULTI_V5
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
