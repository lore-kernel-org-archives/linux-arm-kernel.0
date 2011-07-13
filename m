From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:12 +0100
Subject: [PATCH 23/24] ARM: kprobes: Decode ARM preload (immediate)
	instructions
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-24-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These were missing from the previous implementation.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 70e540b..8a58c99 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1139,6 +1139,12 @@ static const union decode_item arm_1111_table[] = {
 	/* PLD (immediate)	1111 0101 x101 xxxx xxxx xxxx xxxx xxxx */
 	DECODE_SIMULATE	(0xfe300000, 0xf4100000, kprobe_simulate_nop),
 
+	/* memory hint		1111 0110 x001 xxxx xxxx xxxx xxx0 xxxx */
+	/* PLDI (register)	1111 0110 x101 xxxx xxxx xxxx xxx0 xxxx */
+	/* PLDW (register)	1111 0111 x001 xxxx xxxx xxxx xxx0 xxxx */
+	/* PLD (register)	1111 0111 x101 xxxx xxxx xxxx xxx0 xxxx */
+	DECODE_SIMULATE	(0xfe300010, 0xf6100000, kprobe_simulate_nop),
+
 	/* BLX (immediate)	1111 101x xxxx xxxx xxxx xxxx xxxx xxxx */
 	DECODE_SIMULATE	(0xfe000000, 0xfa000000, simulate_blx1),
 
-- 
1.7.2.5
