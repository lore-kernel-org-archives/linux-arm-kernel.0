From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Dec 2013 02:20:54 +0300
Subject: [PATCH 2/2] ARM: shmobile: Lager: conditionally select
 CONFIG_MICREL_PHY
In-Reply-To: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
Message-ID: <201312200220.54747.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that support for KSZ8041RNLI is added to the Micrel PHY driver and we intend
to support PHY IRQs on the Lager board, we have to enable the Micrel driver.
Do this by selecting CONFIG_MICREL_PHY for Lager if CONFIG_SH_ETH is enabled.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/mach-shmobile/Kconfig
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/Kconfig
+++ renesas/arch/arm/mach-shmobile/Kconfig
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
