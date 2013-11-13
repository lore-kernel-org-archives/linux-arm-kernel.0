From: geoff@infradead.org (Geoff Levand)
Date: Wed, 13 Nov 2013 12:36:58 -0800
Subject: [PATCH boot-wrapper-aarch64] Add CFLAGS to makefile compile
Message-ID: <1384375018.5210.6.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 8a5783e72029c1ecd26fb99130b48a470e13a8da Mon Sep 17 00:00:00 2001
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 13 Nov 2013 12:26:01 -0800

Allow user to pass compiler flags on the make command line as
in 'make CFLAGS="-g"'.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Catalin,

Please consider.

-Geoff

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 38595a3..128bebf 100644
--- a/Makefile
+++ b/Makefile
@@ -65,7 +65,7 @@ $(IMAGE): boot.o model.lds fdt.dtb $(KERNEL) $(FILESYSTEM)
 	$(LD) -o $@ --script=model.lds
 
 boot.o: $(BOOTLOADER) Makefile
-	$(CC) $(CPPFLAGS) -DCNTFRQ=$(CNTFRQ) -DUART_BASE=$(UART_BASE) -DSYSREGS_BASE=$(SYSREGS_BASE) -DGIC_DIST_BASE=$(GIC_DIST_BASE) -DGIC_CPU_BASE=$(GIC_CPU_BASE) -c -o $@ $(BOOTLOADER)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -DCNTFRQ=$(CNTFRQ) -DUART_BASE=$(UART_BASE) -DSYSREGS_BASE=$(SYSREGS_BASE) -DGIC_DIST_BASE=$(GIC_DIST_BASE) -DGIC_CPU_BASE=$(GIC_CPU_BASE) -c -o $@ $(BOOTLOADER)
 
 model.lds: $(LD_SCRIPT) Makefile
 	$(CC) $(CPPFLAGS) -DPHYS_OFFSET=$(PHYS_OFFSET) -DMBOX_OFFSET=$(MBOX_OFFSET) -DKERNEL_OFFSET=$(KERNEL_OFFSET) -DFDT_OFFSET=$(FDT_OFFSET) -DFS_OFFSET=$(FS_OFFSET) -DKERNEL=$(KERNEL) -DFILESYSTEM=$(FILESYSTEM) -E -P -C -o $@ $<
-- 
1.8.1.2
