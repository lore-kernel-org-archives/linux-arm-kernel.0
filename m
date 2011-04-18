From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 18 Apr 2011 11:12:18 +0100
Subject: [PATCH 10/14] PM / MIPS: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <201104172312.35060.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172312.35060.rjw@sisk.pl>
Message-ID: <20110418101218.GA25325@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch breaks the Alchemy kernel compile; below patch on top of it fixes
that again.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 arch/mips/alchemy/common/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-mips/arch/mips/alchemy/common/irq.c
===================================================================
--- linux-mips.orig/arch/mips/alchemy/common/irq.c
+++ linux-mips/arch/mips/alchemy/common/irq.c
@@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
 
 static int __init alchemy_ic_syscore_init(void)
 {
-	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
-	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
+	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
+	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
 
 	register_syscore_ops(&alchemy_ic_syscore_ops);
 
