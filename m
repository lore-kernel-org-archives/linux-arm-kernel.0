From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:06 +0100
Subject: [PATCH 17/24] ARM: kprobes: Replace use of
	prep_emulate_rd12rn16rm0_wflags()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-18-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These can now use emulate_rd12rn16rm0_rwflags_nopc().

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index d3b0506..2131506 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1074,7 +1074,8 @@ static const union decode_item arm_cccc_0001_0xx0____0xxx_table[] = {
 	/* QSUB			cccc 0001 0010 xxxx xxxx xxxx 0101 xxxx */
 	/* QDADD		cccc 0001 0100 xxxx xxxx xxxx 0101 xxxx */
 	/* QDSUB		cccc 0001 0110 xxxx xxxx xxxx 0101 xxxx */
-	DECODE_CUSTOM	(0x0f9000f0, 0x01000050, prep_emulate_rd12rn16rm0_wflags),
+	DECODE_EMULATEX	(0x0f9000f0, 0x01000050, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPC, NOPC, 0, 0, NOPC)),
 
 	/* BXJ			cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
 	/* MSR			cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
@@ -1140,7 +1141,8 @@ static const union decode_item arm_cccc_0001_____1001_table[] = {
 	/* Synchronization primitives					*/
 
 	/* SMP/SWPB		cccc 0001 0x00 xxxx xxxx xxxx 1001 xxxx */
-	DECODE_CUSTOM	(0x0fb000f0, 0x01000090, prep_emulate_rd12rn16rm0_wflags),
+	DECODE_EMULATEX	(0x0fb000f0, 0x01000090, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPC, NOPC, 0, 0, NOPC)),
 
 	/* LDREX/STREX{,D,B,H}	cccc 0001 1xxx xxxx xxxx xxxx 1001 xxxx */
 	/* And unallocated instructions...				*/
@@ -1356,11 +1358,13 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
 	/* UHSUB16		cccc 0110 0111 xxxx xxxx xxxx 0111 xxxx */
 	/* UHADD8		cccc 0110 0111 xxxx xxxx xxxx 1001 xxxx */
 	/* UHSUB8		cccc 0110 0111 xxxx xxxx xxxx 1111 xxxx */
-	DECODE_CUSTOM	(0x0f800010, 0x06000010, prep_emulate_rd12rn16rm0_wflags),
+	DECODE_EMULATEX	(0x0f800010, 0x06000010, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPC, NOPC, 0, 0, NOPC)),
 
 	/* PKHBT		cccc 0110 1000 xxxx xxxx xxxx x001 xxxx */
 	/* PKHTB		cccc 0110 1000 xxxx xxxx xxxx x101 xxxx */
-	DECODE_CUSTOM	(0x0ff00030, 0x06800010, prep_emulate_rd12rn16rm0_wflags),
+	DECODE_EMULATEX	(0x0ff00030, 0x06800010, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPC, NOPC, 0, 0, NOPC)),
 
 	/* ???			cccc 0110 1001 xxxx xxxx xxxx 0111 xxxx */
 	/* ???			cccc 0110 1101 xxxx xxxx xxxx 0111 xxxx */
@@ -1380,7 +1384,8 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
 	/* UXTAB16		cccc 0110 1100 xxxx xxxx xxxx 0111 xxxx */
 	/* UXTAB		cccc 0110 1110 xxxx xxxx xxxx 0111 xxxx */
 	/* UXTAH		cccc 0110 1111 xxxx xxxx xxxx 0111 xxxx */
-	DECODE_CUSTOM	(0x0f8000f0, 0x06800070, prep_emulate_rd12rn16rm0_wflags),
+	DECODE_EMULATEX	(0x0f8000f0, 0x06800070, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPCX, NOPC, 0, 0, NOPC)),
 
 	DECODE_END
 };
-- 
1.7.2.5
