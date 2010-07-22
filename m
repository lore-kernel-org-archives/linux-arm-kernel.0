From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Jul 2010 10:43:07 +0200
Subject: [PATCH] Make SPARSE_IRQ a hidden option
Message-ID: <AANLkTimmwLIubkxfagve_QBfD9KahO57Q_-vwhV3h4VU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] Make SPARSE_IRQ a hidden option

    SPARSE_IRQ doesn't need to be a visible option, only those platforms
    supporting that will select it.

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c810765..2b3f84f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1263,8 +1263,7 @@ config HW_PERF_EVENTS
 	  disabled, perf events will use software events only.

 config SPARSE_IRQ
-	bool "Support sparse irq numbering"
-	depends on EXPERIMENTAL
+	def_bool n
 	help
 	  This enables support for sparse irqs. This is useful in general
 	  as most CPUs have a fairly sparse array of IRQ vectors, which
@@ -1272,8 +1271,6 @@ config SPARSE_IRQ
 	  number of off-chip IRQs will want to treat this as
 	  experimental until they have been independently verified.

-	  If you don't know what to do here, say N.
-
 source "mm/Kconfig"

 config FORCE_MAX_ZONEORDER
