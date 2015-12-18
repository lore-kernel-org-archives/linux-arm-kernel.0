From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 16:22:20 +0100
Subject: [RFC, PATCH] ARM: documentation: update Marvell product listing
Message-ID: <1642213.KLTG4bHaur@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm still getting confused regarding which core specifically
is used in which SoC, so I've added some more detail to the
Marvell README file. I got most of this from random sources
on the internet, so it's possible that some of the information
is wrong, but most of it should be pretty obvious.

There are a few remaining points I could not find out:

* The CPU core in Orion 88F6183
* The difference (if any) between PJ4B-MP and PJ4C
* The naming of Feroceon/Jolteon/Flareon/Sheeva/Mohawk/PJ1/PJ4
  is still confusing, as they tend to overlap.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index ae89b67d8e23..1f7523df0302 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -22,7 +22,7 @@ Orion family
         88F5281
                Datasheet               : http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
         88F6183
-  Core: Feroceon ARMv5 compatible
+  Core: Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
   Linux kernel mach directory: arch/arm/mach-orion5x
   Linux kernel plat directory: arch/arm/plat-orion
 
@@ -52,7 +52,7 @@ Kirkwood family
                 Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
                 Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
   Homepage: http://www.marvell.com/embedded-processors/kirkwood/
-  Core: Feroceon ARMv5 compatible
+  Core: Feroceon 88fr131 ARMv5 compatible
   Linux kernel mach directory: arch/arm/mach-mvebu
   Linux kernel plat directory: none
 
@@ -71,7 +71,7 @@ Discovery family
         MV76100
                 Not supported by the Linux kernel.
 
-  Core: Feroceon ARMv5 compatible
+  Core: Feroceon 88fr571-vd ARMv5 compatible
 
   Linux kernel mach directory: arch/arm/mach-mv78xx0
   Linux kernel plat directory: arch/arm/plat-orion
@@ -86,20 +86,30 @@ EBU Armada family
     Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
     Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
     Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+    Core: Sheeva ARMv7 compatible PJ4B
 
   Armada 375 Flavors:
 	88F6720
     Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
-
-  Armada 380/385 Flavors:
-	88F6810
-	88F6820
-	88F6828
-
-  Armada 390/398 Flavors:
-	88F6920
-	88F6928
+    Core: ARM Cortex-A9
+
+  Armada 38x Flavors:
+	88F6810	Armada 380
+	88F6820 Armada 385
+	88F6828 Armada 388
+    Produce infos: http://www.marvell.com/embedded-processors/armada-38x/
+    Core: ARM Cortex-A9
+
+  Armada 39x Flavors:
+	88F6920 Armada 390
+	88F6928 Armada 398
     Product infos: http://www.marvell.com/embedded-processors/armada-39x/
+    Core: ARM Cortex-A9
+
+  Armada SP:
+	88RC1580
+    Product infos: http://www.marvell.com/embedded-processors/armada-sp/
+    Core: Sheeva ARMv7 comatible Quad-core PJ4C
 
   Armada XP Flavors:
         MV78230
@@ -113,7 +123,7 @@ EBU Armada family
       http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
       http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
 
-  Core: Sheeva ARMv7 compatible
+  Core: Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
 
   Linux kernel mach directory: arch/arm/mach-mvebu
   Linux kernel plat directory: none
@@ -155,7 +165,7 @@ PXA 2xx/3xx/93x/95x family
   Flavors:
         PXA21x, PXA25x, PXA26x
              Application processor only
-             Core: ARMv5 XScale core
+             Core: ARMv5 XScale1 core
         PXA270, PXA271, PXA272
              Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
              Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
@@ -163,7 +173,7 @@ PXA 2xx/3xx/93x/95x family
              Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
              Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
              Application processor only
-             Core: ARMv5 XScale core
+             Core: ARMv5 XScale2 core
         PXA300, PXA310, PXA320
              PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
              PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
@@ -174,10 +184,10 @@ PXA 2xx/3xx/93x/95x family
              Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
              Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
              Application processor only
-             Core: ARMv5 XScale core
+             Core: ARMv5 XScale3 core
         PXA930, PXA935
              Application processor with Communication processor
-             Core: ARMv5 XScale core
+             Core: ARMv5 XScale3 core
         PXA955
              Application processor with Communication processor
              Core: ARMv7 compatible Sheeva PJ4 core
@@ -196,7 +206,7 @@ PXA 2xx/3xx/93x/95x family
    Linux kernel mach directory: arch/arm/mach-pxa
    Linux kernel plat directory: arch/arm/plat-pxa
 
-MMP/MMP2 family (communication processor)
+MMP/MMP2/MMP3 family (communication processor)
 -----------------------------------------
 
    Flavors:
@@ -209,16 +219,32 @@ MMP/MMP2 family (communication processor)
              Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
              App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
              Application processor only
-             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
-        PXA910
+             Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
+        PXA910/PXA920
              Homepage             : http://www.marvell.com/communication-processors/pxa910/
              Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
              Application processor with Communication processor
-             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
-        MMP2, a.k.a Armada 610
+             Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
+        PXA688, a.k.a. MMP2, a.k.a Armada 610
              Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
              Application processor only
-             Core: ARMv7 compatible Sheeva PJ4 core
+             Core: ARMv7 compatible Sheeva PJ4 88sv581x core
+	PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
+	     Product Brief	  : http://www.marvell.com/application-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+	     Application processor only
+	     Core: Dual-core ARMv7 compatible Sheeva PJ4C core
+	PXA960/PXA968/PXA978 (Linux support not upstream)
+	     Application processor with Communication Processor
+	     Core: ARMv7 compatible Sheeva PJ4 core
+	PXA986/PXA988 (Linux support not upstream)
+	     Application processor with Communication Processor
+	     Core: Dual-core ARMv7 compatible Sheeva PJ4B-MP core
+	PXA1088/PXA1920 (Linux support not upstream)
+	     Application processor with Communication Processor
+	     Core: quad-core ARMv7 Cortex-A7
+	PXA1908/PXA1928/PXA1936
+	     Application processor with Communication Processor
+	     Core: multi-core ARMv8 Cortex-A53
 
    Comments:
 
@@ -237,6 +263,10 @@ Berlin family (Multimedia Solutions)
 -------------------------------------
 
   Flavors:
+	88DE3010, Armada 1000 (no Linux support)
+		Core:		Marvell PJ1 (ARMv5TE), Dual-core
+		Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
+	88DE3005, Armada 1500-mini
 	88DE3005, Armada 1500 Mini
 		Design name:	BG2CD
 		Core:		ARM Cortex-A9, PL310 L2CC
@@ -247,14 +277,16 @@ Berlin family (Multimedia Solutions)
                 Homepage:       http://www.marvell.com/multimedia-solutions/armada-1500-mini-plus/
 	88DE3100, Armada 1500
 		Design name:	BG2
-		Core:		Marvell PJ4B (ARMv7), Tauros3 L2CC
-		Product Brief:	http://www.marvell.com/multimedia-solutions/armada-1500/assets/Marvell-ARMADA-1500-Product-Brief.pdf
+		Core:		Marvell PJ4B-MP (ARMv7), Tauros3 L2CC
+		Product Brief:	http://www.marvell.com/digital-entertainment/armada-1500/assets/Marvell-ARMADA-1500-Product-Brief.pdf
 	88DE3114, Armada 1500 Pro
 		Design name:	BG2Q
 		Core:		Quad Core ARM Cortex-A9, PL310 L2CC
-	88DE????
+	88DE3214, Armada 1500 Pro 4K
 		Design name:	BG3
 		Core:		ARM Cortex-A15, CA15 integrated L2CC
+	88DE3218, ARMADA 1500 Ultra
+		Core:		ARM Cortex-A53
 
   Homepage: http://www.marvell.com/multimedia-solutions/
   Directory: arch/arm/mach-berlin
@@ -263,6 +295,49 @@ Berlin family (Multimedia Solutions)
    * This line of SoCs is based on Marvell Sheeva or ARM Cortex CPUs
      with Synopsys DesignWare (IRQ, GPIO, Timers, ...) and PXA IP (SDHCI, USB, ETH, ...).
 
+CPU Cores
+---------
+
+The XScale cores were designed by Intel, and shipped by Marvell in the older
+PXA processors. Feroceon is a Marvell designed core that developed in-house,
+and that evolved into Sheeva. The XScale and Feroceon cores were phased out
+over time and replaced with Sheeva cores in later products, which subsequently
+got replaced with licensed ARM Cortex-A cores.
+
+  XScale 1
+	CPUID 0x69052xxx
+	ARMv5, iWMMXt
+  XScale 2
+	CPUID 0x69054xxx
+	ARMv5, iWMMXt
+  XScale 3
+	CPUID 0x69056xxx or 0x69056xxx
+	ARMv5, iWMMXt
+  Feroceon-1850 88fr331 "Mohawk"
+	CPUID 0x5615331x or 0x41xx926x
+	ARMv5TE, single issue
+  Feroceon-2850 88fr531-vd "Jolteon"
+	CPUID 0x5605531x or 0x41xx926x
+	ARMv5TE, VFP, dual-issue
+  Feroceon 88fr571-vd "Jolteon"
+	CPUID 0x5615571x
+	ARMv5TE, VFP, dual-issue
+  Feroceon 88fr131 "Mohawk-D"
+	CPUID 0x5625131x
+	ARMv5TE, single-issue in-order
+  Sheeva PJ1 88sv331 "Mohawk"
+	CPUID 0x561584xx
+	ARMv5, single-issue iWMMXt v2
+  Sheeva PJ4 88sv581x "Flareon"
+	CPUID 0x560f581x
+	ARMv7, idivt, optional iWMMXt v2
+  Sheeva PJ4B 88sv581x
+	CPUID 0x561f581x
+	ARMv7, idivt, optional iWMMXt v2
+  Sheeva PJ4B-MP / PJ4C
+	CPUID 0x562f584x
+	ARMv7, idivt/idiva, LPAE, optional iWMMXt v2 and/or NEON
+
 Long-term plans
 ---------------
 
