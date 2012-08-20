From: Barry.Song@csr.com (Barry Song)
Date: Mon, 20 Aug 2012 16:19:47 +0800
Subject: [PATCH 3/3] ARM: SIRF: make sirf irqchip driver selectable since new
 SoCs will have GIC
In-Reply-To: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345450787-17246-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

New MARCO and POLO SoC uses GIC, so make irq.c selectable and select
it for PRIMAII

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-sirf/Kconfig  |    4 ++++
 arch/arm/mach-sirf/Makefile |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sirf/Kconfig b/arch/arm/mach-sirf/Kconfig
index 811e782..fea4bd9 100644
--- a/arch/arm/mach-sirf/Kconfig
+++ b/arch/arm/mach-sirf/Kconfig
@@ -8,9 +8,13 @@ config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	select CPU_V7
 	select ZONE_DMA
+	select SIRF_IRQ
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
 endchoice
 
+config SIRF_IRQ
+	bool
+
 endif
diff --git a/arch/arm/mach-sirf/Makefile b/arch/arm/mach-sirf/Makefile
index 852af49..3103fdf 100644
--- a/arch/arm/mach-sirf/Makefile
+++ b/arch/arm/mach-sirf/Makefile
@@ -1,8 +1,8 @@
 obj-y := timer.o
-obj-y += irq.o
 obj-y += rstc.o
 obj-y += board-generic.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
+obj-$(CONFIG_SIRF_IRQ) += irq.o
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
