From: jason77.wang@gmail.com (Hui Wang)
Date: Tue, 17 Jul 2012 16:37:10 +0800
Subject: [PATCH] irqdomain: let the output of irq number align from left side
Message-ID: <1342514230-8729-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Except irq number, the rest columns all align from left side, the
output is ugly as following shows,
irq    hwirq    chip name        chip data   domain name
   29  0x0001d  GIC              0x805e1070  /interrupt-<snip>
   34  0x00022  GIC              0x805e1070  /interrupt-<snip>

After applying the fix, the output like that,
irq    hwirq    chip name        chip data   domain name
29     0x0001d  GIC              0x805e1070  /interrupt-<snip>
34     0x00022  GIC              0x805e1070  /interrupt-<snip>

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
This is a trivial output alignment fix, i don't know if Grant
still maintain the irqdomain subsystem, Cced to Mark for a
backup.

 kernel/irq/irqdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 41c1564..575e643 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -712,7 +712,7 @@ static int virq_debug_show(struct seq_file *m, void *private)
 		if (desc->action && desc->action->handler) {
 			struct irq_chip *chip;
 
-			seq_printf(m, "%5d  ", i);
+			seq_printf(m, "%-5d  ", i);
 			seq_printf(m, "0x%05lx  ", desc->irq_data.hwirq);
 
 			chip = irq_desc_get_chip(desc);
-- 
1.7.6
