From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 11 Jun 2012 13:48:52 +0530
Subject: [PATCH] ARM: kprobes: run t32_simulate_ldr_literal() without insn slot
Message-ID: <1339402732-20849-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

t32_simulate_ldr_literal() can be run without an instruction slot, so it
should be using DECODE_SIMULATEX instead of DECODE_EMULATEX.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/kernel/kprobes-thumb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 8f96ec7..6123daf 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -660,7 +660,7 @@ static const union decode_item t32_table_1111_100x[] = {
 	/* LDRSB (literal)	1111 1001 x001 1111 xxxx xxxx xxxx xxxx */
 	/* LDRH (literal)	1111 1000 x011 1111 xxxx xxxx xxxx xxxx */
 	/* LDRSH (literal)	1111 1001 x011 1111 xxxx xxxx xxxx xxxx */
-	DECODE_EMULATEX	(0xfe5f0000, 0xf81f0000, t32_simulate_ldr_literal,
+	DECODE_SIMULATEX(0xfe5f0000, 0xf81f0000, t32_simulate_ldr_literal,
 						 REGS(PC, NOSPPCX, 0, 0, 0)),
 
 	/* STRB (immediate)	1111 1000 0000 xxxx xxxx 1xxx xxxx xxxx */
-- 
1.7.9.5
