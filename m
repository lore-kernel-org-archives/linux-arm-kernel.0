From: Barry.Song@csr.com (Barry Song)
Date: Mon, 20 Aug 2012 14:42:37 +0800
Subject: [PATCH v4 2/2] clk: prima2: move from arch/arm/mach to drivers/clk
In-Reply-To: <1345444957-16039-1-git-send-email-Barry.Song@csr.com>
References: <1345444957-16039-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345444957-16039-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 -v4: rename to clk-prima2 as we will have clk-marco or others

 arch/arm/mach-prima2/Makefile                      |    1 -
 drivers/clk/Makefile                               |    1 +
 .../clock.c => drivers/clk/clk-prima2.c            |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-prima2/clock.c => drivers/clk/clk-prima2.c (100%)

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
index 5869ea3..d4c7253 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
+obj-$(CONFIG_ARCH_PRIMA2)	+= clk-prima2.o
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/arch/arm/mach-prima2/clock.c b/drivers/clk/clk-prima2.c
similarity index 100%
rename from arch/arm/mach-prima2/clock.c
rename to drivers/clk/clk-prima2.c
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
