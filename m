From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 22:59:40 +0200
Subject: [PATCH] genirq: fix handle_bad_irq kerneldoc comment
In-Reply-To: <201510070422.sqnilsXm%fengguang.wu@intel.com>
References: <201510070422.sqnilsXm%fengguang.wu@intel.com>
Message-ID: <5400000.cD19rmgWjV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent cleanup removed the 'irq' parameter from many functions, but
left the documentation for this in place for at least one function.

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bd0b9ac405e1 ("genirq: Remove irq argument from irq flow handlers")
---
On Wednesday 07 October 2015 04:51:56 kbuild test robot wrote:
> [auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]
> 
> reproduce: make htmldocs
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/irq/handle.c:31: warning: Excess function parameter 'irq' description in 'handle_bad_irq'
> >> kernel/irq/handle.c:1: warning: no structured comments found

This seems to be an unrelated bug, not sure why it wasn't caught earlier:

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 142bbf3b607f..a302cf9a2126 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -22,7 +22,6 @@
 
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
- * @irq:       the interrupt number
  * @desc:      description of the interrupt
  *
  * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
