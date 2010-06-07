From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon,  7 Jun 2010 18:49:19 +0100
Subject: [PATCH] pxa168 and pxa930 build fix - plat-pxa/pmu.c dependent on
	ARCH_PXA for IRQ_PMU
Message-ID: <1275932959-474-1-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 Found this build issue whilst browsing kautobuild logs.
 There may well be a better fix but until someone with
 a board in ARCH_MMP can test it, lets just not build
 pmu.c.  Can't find equivalent fix in Eric's tree so I
 think this is still a live problem.

 arch/arm/plat-pxa/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 6187edf..a17cc0c 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -2,8 +2,9 @@
 # Makefile for code common across different PXA processor families
 #
 
-obj-y	:= dma.o pmu.o
+obj-y	:= dma.o
 
+obj-$(CONFIG_ARCH_PXA)		+= pmu.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
-- 
1.6.4.4
