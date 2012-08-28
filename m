From: davidb@codeaurora.org (David Brown)
Date: Tue, 28 Aug 2012 11:59:58 -0700
Subject: [PATCH] ARM: Make sure dtc is built before running it
Message-ID: <1346180398-8079-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'make dtbs' in a clean tree will try running the dtc before actually
building it.  Make these rules depend upon the scripts to build it.
---
 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0298b00..926d840 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -279,10 +279,10 @@ zImage Image xipImage bootpImage uImage: vmlinux
 zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
-%.dtb:
+%.dtb: scripts
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
-dtbs:
+dtbs: scripts
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
