From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 12 Nov 2009 14:58:07 +0100
Subject: [PATCH] ARM: Prefix revision number in /proc/cpuinfo
Message-ID: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The revision field in /proc/cpuinfo is reported as hex number, so it
should have a '0x' prefix to make that clear. Otherwise, parsers
will take it as decimal number unless it contains a letter.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..73eb2c8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -860,7 +860,7 @@ static int c_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
-	seq_printf(m, "Revision\t: %04x\n", system_rev);
+	seq_printf(m, "Revision\t: 0x%04x\n", system_rev);
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
 
-- 
1.6.5.2
