From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 16 Oct 2016 12:08:20 +0200
Subject: [PATCH] ARM-mm-dump: Use seq_putc() in note_page()
Message-ID: <af582fdc-25d3-4378-b979-bea990ca6850@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 16 Oct 2016 12:00:26 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mm/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 9fe8e24..4bd8f9a 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -241,7 +241,7 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u
 			seq_printf(st->seq, "%9lu%c", delta, *unit);
 			if (pg_level[st->level].bits)
 				dump_prot(st, pg_level[st->level].bits, pg_level[st->level].num);
-			seq_printf(st->seq, "\n");
+			seq_putc(st->seq, '\n');
 		}
 
 		if (addr >= st->marker[1].start_address) {
-- 
2.10.1
