From: mmarek@suse.cz (Michal Marek)
Date: Thu,  2 Oct 2014 15:44:02 +0200
Subject: [PATCH] IXP4xx: Makefile cleanup
Message-ID: <1412257442-4362-1-git-send-email-mmarek@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

obj-pci-n will never be assigned or used. obj-pci-y does not need to be
initialized, because each Kbuild file is processed separately.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/arm/mach-ixp4xx/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index eded94c..2ecc4c9 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -2,9 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-pci-y	:=
-obj-pci-n	:=
-
 obj-pci-$(CONFIG_ARCH_IXDP4XX)		+= ixdp425-pci.o
 obj-pci-$(CONFIG_MACH_AVILA)		+= avila-pci.o
 obj-pci-$(CONFIG_MACH_IXDPG425)		+= ixdpg425-pci.o
-- 
1.8.4.5
