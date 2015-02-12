From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:42 +0100
Subject: [PATCH 10/11] ARM: sti: always enable RESET_CONTROLLER
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of the sti device drivers require reset controller support,
but do not all have individual 'depends on RESET_CONTROLLER'
statements. Using 'select' here once avoids a lot of build errors
resulting from this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-sti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 8825bc9e2553..3b1ac463a494 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_STI
 	select ARM_ERRATA_775420
 	select PL310_ERRATA_753970 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select RESET_CONTROLLER
 	help
 	  Include support for STiH41x SOCs like STiH415/416 using the device tree
 	  for discovery
-- 
2.1.0.rc2
