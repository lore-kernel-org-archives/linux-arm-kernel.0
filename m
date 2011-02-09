From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 9 Feb 2011 21:33:23 +0300
Subject: [PATCH] DaVinci: fix compilation warnings in <mach/clkdev.h>
Message-ID: <201102092133.23765.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6d803ba736abb5e122dede70a4720e4843dd6df4 (ARM: 6483/1: arm & sh:
factorised duplicated clkdev.c) caused the following warnings:

In file included from /home/headless/src/kernel.org/linux-davinci/arch/arm/
include/asm/clkdev.h:17,
                 from include/linux/clkdev.h:15,
                 from arch/arm/mach-davinci/clock.h:71,
                 from arch/arm/mach-davinci/common.c:22:
arch/arm/mach-davinci/include/mach/clkdev.h:4: warning: `struct clk' declared
inside parameter list
arch/arm/mach-davinci/include/mach/clkdev.h:4: warning: its scope is only this
definition or declaration, which is probably not what you want
arch/arm/mach-davinci/include/mach/clkdev.h:9: warning: `struct clk' declared
inside parameter list

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree.

 arch/arm/mach-davinci/include/mach/clkdev.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-davinci/arch/arm/mach-davinci/include/mach/clkdev.h
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/include/mach/clkdev.h
+++ linux-davinci/arch/arm/mach-davinci/include/mach/clkdev.h
@@ -1,6 +1,8 @@
 #ifndef __MACH_CLKDEV_H
 #define __MACH_CLKDEV_H
 
+struct clk;
+
 static inline int __clk_get(struct clk *clk)
 {
 	return 1;
