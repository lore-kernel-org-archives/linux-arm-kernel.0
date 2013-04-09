From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 22:01:18 +0200
Subject: [GIT PULL 7/8] ARM: tegra: multi-platform conversion
In-Reply-To: <201304091659.08376.arnd@arndb.de>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-7-git-send-email-swarren@wwwdotorg.org>
 <201304091659.08376.arnd@arndb.de>
Message-ID: <201304092201.18950.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Arnd Bergmann wrote:
> On Friday 05 April 2013, Stephen Warren wrote:
> > This branch converts Tegra to support multi-platform/single-zImage.

> I had to reorder the branches in arm-soc to avoid starting a
> next/multiplatform2 branch, but I saw nothing that prevents us from
> having multiplatform after soc.

I've applied this patch on top.

>From 1939e142b04d91b97a8643dd68c4b3fae48a136b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Apr 2013 21:58:38 +0200
Subject: [PATCH] ARM: tegra: build assembly files with -march=armv7-a

The tegra assembly files are written for ARMv7 and are not compatible
with ARMv6, which leads to build warnings when compiling a dual
ARMv6/v7 kernel. Since this code is only ever run on Tegra ARMv7
hardware, we can tell the assembler which architecture level to
use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e40326d..bfc5b07 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,3 +1,5 @@
+asflags-y				+= -march=armv7-a
+
 obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
