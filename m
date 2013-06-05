From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:06:40 +0900
Subject: [PATCH 03/15] ARM: shmobile: AP4EVB uImage rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070640.13311.38199.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add AP4EVB specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0010/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:09:11.000000000 +0900
@@ -2,6 +2,7 @@ loadaddr-y	:= $(shell /bin/bash -c 'prin
 		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
 
 loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
 
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
