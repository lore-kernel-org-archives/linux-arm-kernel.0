From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 12 Nov 2009 14:53:19 +0100
Subject: [PATCH] ARM: Prefix hex numbers in /proc/cpuinfo
Message-ID: <mailman.16.1258036639.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'Revision' and 'Serial' fields in /proc/cpuinfo are reported as hex
numbers, so they should have a '0x' prefix to make that clear.
Otherwise, parsers will take them as decimal number unless they contain
a letter.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..1bd2aa6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -860,8 +860,8 @@ static int c_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
-	seq_printf(m, "Revision\t: %04x\n", system_rev);
-	seq_printf(m, "Serial\t\t: %08x%08x\n",
+	seq_printf(m, "Revision\t: 0x%04x\n", system_rev);
+	seq_printf(m, "Serial\t\t: 0x%08x%08x\n",
 		   system_serial_high, system_serial_low);
 
 	return 0;
-- 
1.6.5.2
