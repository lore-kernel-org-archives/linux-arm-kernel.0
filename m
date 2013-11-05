From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 05 Nov 2013 19:09:14 +0100
Subject: [patch 1/1] ARM: kirkwood: stop printk TCLK value at boot for DT
 boards
Message-ID: <20131105180931.674625171@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2326f04321a9 (ARM: kirkwood: convert to DT irqchip and clocksource)
dropped the call to kirkwood_timer_init() when booting with DT.
This results in kirkwood_tclk not being set and the boot message is now:

Kirkwood: MV88F6281-A0, TCLK=0

This patch modifies the message for printing only the kirkwood id,
as it allows to detect if we're running A0/A1/... variants with a simple
dmesg.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

Index: linux-next/arch/arm/mach-kirkwood/board-dt.c
===================================================================
--- linux-next.orig/arch/arm/mach-kirkwood/board-dt.c	2013-11-05 18:36:23.131191305 +0100
+++ linux-next/arch/arm/mach-kirkwood/board-dt.c	2013-11-05 18:36:35.867190745 +0100
@@ -140,7 +140,7 @@ eth_fixup_skip:
 
 static void __init kirkwood_dt_init(void)
 {
-	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
+	pr_info("Kirkwood: %s.\n", kirkwood_id());
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
