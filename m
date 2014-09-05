From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Sep 2014 08:48:12 +0200
Subject: [PATCH 6/6] dts,
 arm: Remove $(MACHINE) variable from dtbs make recipes
In-Reply-To: <1409899692-1455-1-git-send-email-rric@kernel.org>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
Message-ID: <1409899692-1455-7-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

The machine description is not needed to build dtb files.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4d13c6d0a0cc..422c9aa34382 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -315,10 +315,10 @@ $(BOOT_TARGETS): vmlinux
 PHONY += dtbs dtbs_install
 
 dtbs: prepare scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE)
+	$(Q)$(MAKE) $(build)=$(boot)/dts
 
 dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts MACHINE=$(MACHINE)
+	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
-- 
2.0.1
