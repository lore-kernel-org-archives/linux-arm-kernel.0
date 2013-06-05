From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:06:48 +0900
Subject: [PATCH 04/15] ARM: shmobile: APE6EVM uImage rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070648.13311.86610.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add APE6EVM specific load address to Makefile.boot

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- 0011/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:11:28.000000000 +0900
@@ -3,6 +3,7 @@ loadaddr-y	:= $(shell /bin/bash -c 'prin
 
 loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
+loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
