From: Baohua.Song@csr.com (Barry Song)
Date: Sun, 4 Sep 2011 22:15:18 -0700
Subject: [PATCH 3/3] ARM: CSR: IRQ: add simple irq_domain so that hw irq can
	map to Linux
In-Reply-To: <1315199718-10102-1-git-send-email-Baohua.Song@csr.com>
References: <1315199718-10102-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1315199718-10102-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/irq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index c3404cb..d888b8d 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -13,6 +13,7 @@
 #include <asm/mach/irq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/irqdomain.h>
 
 #define SIRFSOC_INT_RISC_MASK0          0x0018
 #define SIRFSOC_INT_RISC_MASK1          0x001C
@@ -65,6 +66,8 @@ void __init sirfsoc_of_irq_init(void)
 	if (!sirfsoc_intc_base)
 		panic("unable to map intc cpu registers\n");
 
+	irq_domain_add_simple(np, 0);
+
 	of_node_put(np);
 
 	sirfsoc_irq_init();
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
