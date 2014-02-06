From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:18:53 +0900
Subject: [PATCH 01/21] ARM: shmobile: Lager: conditionally select
 CONFIG_MICREL_PHY
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <a2a4759b5262979cbe4bc1f681ec5a6ab064fce3.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Now that support for KSZ8041RNLI is added to the Micrel PHY driver and we intend
to support PHY IRQs on the Lager board, we have to enable the Micrel driver.
Do this by selecting CONFIG_MICREL_PHY for Lager if CONFIG_SH_ETH is enabled.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3386406..a127252 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -54,6 +54,7 @@ config MACH_KZM9D
 config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
+	select MICREL_PHY if SH_ETH
 
 comment "Renesas ARM SoCs System Configuration"
 endif
@@ -261,6 +262,7 @@ config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
 	select USE_OF
+	select MICREL_PHY if SH_ETH
 
 config MACH_KOELSCH
 	bool "Koelsch board"
-- 
1.8.5.2
