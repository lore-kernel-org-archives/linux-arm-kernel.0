From: Barry.Song@csr.com (Barry Song)
Date: Thu, 19 Jul 2012 16:07:15 +0800
Subject: [PATCH v2 RESEND 2/2] clk: prima2: move from arch/arm/mach to
 drivers/clk
In-Reply-To: <1342685235-7028-1-git-send-email-Barry.Song@csr.com>
References: <1342685235-7028-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1342685235-7028-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/Makefile                      |    1 -
 drivers/clk/Makefile                               |    1 +
 .../mach-prima2/clock.c => drivers/clk/clk-sirf.c  |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-prima2/clock.c => drivers/clk/clk-sirf.c (100%)

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 13dd160..841847d 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -1,6 +1,5 @@
 obj-y := timer.o
 obj-y += irq.o
-obj-y += clock.o
 obj-y += rstc.o
 obj-y += prima2.o
 obj-y += rtciobrg.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 02ffdf6..01821bb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 # SoCs specific
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
+obj-$(CONFIG_ARCH_PRIMA2)	+= clk-sirf.o
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
diff --git a/arch/arm/mach-prima2/clock.c b/drivers/clk/clk-sirf.c
similarity index 100%
rename from arch/arm/mach-prima2/clock.c
rename to drivers/clk/clk-sirf.c
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
