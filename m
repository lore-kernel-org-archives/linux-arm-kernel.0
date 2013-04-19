From: s.gottschall@dd-wrt.com (Sebastian Gottschall)
Date: Fri, 19 Apr 2013 20:07:15 +0200
Subject: arm: ARM_VIRT_EXT is not supported by all v7 platforms, so it should
 not be enabled by default
Message-ID: <kks14c$e4p$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

introduced in kernel 3.9 CONFIG_ARM_VIRT_EXT is default for all V7 arm 
cpu's. this is wrong and breaks smp support on BCM4708 for example.
so keep it optional since no all v7 cpu's seem to support it. BCM4708 
for instance is a arm cortex-a9. please merge this into one of the next 
patches.


Index: arch/arm/mm/Kconfig
===================================================================
--- arch/arm/mm/Kconfig     (revision 21211)
+++ arch/arm/mm/Kconfig     (working copy)
@@ -640,8 +640,7 @@

  config ARM_VIRT_EXT
         bool
-       depends on MMU
-       default y if CPU_V7
+       depends on MMU && CPU_V7
         help
           Enable the kernel to make use of the ARM Virtualization
           Extensions to install hypervisors without run-time firmware
