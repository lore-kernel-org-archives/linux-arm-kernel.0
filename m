From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:07:28 +0900
Subject: [PATCH 09/15] ARM: shmobile: KZM9G uImage rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070728.13311.22698.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add KZM9G specific load addresses to Makefile.boot,
both the C version of the code is covered as well
as the DT -reference code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    2 ++
 1 file changed, 2 insertions(+)

--- 0016/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 16:21:45.000000000 +0900
@@ -8,6 +8,8 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA)
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BONITO) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
+loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 
 __ZRELADDR	:= $(shell /bin/bash -c \
 		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
