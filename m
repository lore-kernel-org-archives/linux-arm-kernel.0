From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:15 -0600
Subject: [PATCH 03/20] OMAP1: OPP: add KConfig entry for 96MHz ARM rate
	(using a 12MHz oscillator)
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152912.6221.48228.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add KConfig entry for one of the OMAP1 DVFS rates that was missing it.
Based on the surrounding rate KConfigs and the oscillator frequency,
this patch marks it as valid for all OMAP1 platforms -- Richard,
Tuukka, Tony, perhaps you can comment if this does not look right?

In the long term, all of these CONFIG_OMAP_ARM_*MHZ should be removed.
The OPP settings should be associated with the platform information in
the structure data (perhaps by extending the omap_chip defines).  The
selection of which rates to use should be handled at runtime; rates
that are impossible due to xtal frequency mismatch or SoC-type
mismatch should not be included.  If implemented correctly, this
should save some CPU time and some memory on OMAP1 kernels.

Reported-by: Christoph Egger <siccegge@cs.fau.de>
Reported-by: The VAMOS Research Project <vamos@i4.informatik.uni-erlangen.de>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Tuukka Tikkanen <tuukka.tikkanen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index b18d7c2..b9f0c4c 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -224,6 +224,12 @@ config OMAP_ARM_120MHZ
 	help
           Enable 120MHz clock for OMAP CPU. If unsure, say N.
 
+config OMAP_ARM_96MHZ
+	bool "OMAP ARM 96 MHz CPU"
+	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
+	help
+          Enable 96MHz clock for OMAP CPU. If unsure, say N.
+
 config OMAP_ARM_60MHZ
 	bool "OMAP ARM 60 MHz CPU"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
