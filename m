From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 17:35:15 +0200
Subject: [PATCH v2] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1342539315-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As stated in the introduction of the document, the families of ARM
SoCs at Marvell are very complicated, and it is difficult for
newcomers to understand the organization of this SoC family and how it
relates to the Linux kernel support for those hardware platforms.

This document is only at RFC stage for now, it requires reviews and
comments from the Marvell maintainers, the PXA maintainers and the MMP
maintainers. For correctness of course, but also to add any other
information that would be useful. For example, one of the thing that
wasn't clear how to detail in the documentation is how the SoCs relate
to each other in terms of hardware IP blocks. For example, most of the
Kirkwood/Dove/Armada 370-XP/etc. hardware IPs (I2C, SPI, USB, SATA,
etc.) are identical, while the PXA and MMP families are completely
separate.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Maen Suleiman <maen@marvell.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>
Cc: Shadi Ammouri <shadi@marvell.com>
Cc: Eran Ben-Avi <benavi@marvell.com>

---
Changes from v1:
 * Added publicly available datasheet for the 88F5182 pointed by
   Andrew Lunn.
 * Added publicly available datasheet for the 88F5281 found with
   Google searches
 * Mentionned the Feroceon core name where appropriate, and Sheeva
   where appropriate
 * Fixed the core names for PXA930, PXA935 and PXA955 after comments
   from Arnd Bergmann. Wikipedia is mistakenly suggesting that PXA93x
   are Sheeva-based, and there isn't much information available on the
   web about the 955.
---
 Documentation/arm/Marvell/README |  173 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/arm/Marvell/README

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
new file mode 100644
index 0000000..ce37bf7
--- /dev/null
+++ b/Documentation/arm/Marvell/README
@@ -0,0 +1,173 @@
+ARM Marvell SoCs
+================
+
+This document lists all the ARM Marvell SoCs that are currently
+supported in mainline by the Linux kernel. As the Marvell families of
+SoCs are large and complex, it is hard to understand where the support
+for a particular SoC is available in the Linux kernel. This document
+tries to help in understanding where those SoCs are supported, and to
+match them with their corresponding public datasheet, when available.
+
+Orion family
+------------
+
+  Flavors:
+        88F5082
+        88F5181
+        88F5181L
+        88F5182
+               Datasheet               : http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
+               Programmer's User Guide : http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
+               User Manual             : http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
+        88F5281
+               Datasheet               : http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+        88F6183
+  Core: Feroceon ARMv5 compatible
+  Linux kernel directory: arch/arm/mach-orion5x
+
+Kirkwood family
+---------------
+
+  Flavors:
+        88F6282 a.k.a Armada 300
+                Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+        88F6283 a.k.a Armada 310
+                Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+        88F6190
+                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-003_WEB.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        88F6192
+                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        88F6182
+        88F6180
+                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        88F6281
+                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+  Homepage: http://www.marvell.com/embedded-processors/kirkwood/
+  Core: Feroceon ARMv5 compatible
+  Linux kernel directory: arch/arm/mach-kirkwood
+
+Discovery family
+----------------
+
+  Flavors:
+        MV78100
+                Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100-003_WEB.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+        MV78200
+                Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200-002_WEB.pdf
+                Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
+                Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+        MV76100
+                Not supported by the Linux kernel.
+  Core: Feroceon ARMv5 compatible
+  Linux kernel directory: arch/arm/mach-mv78xx0
+
+EBU Armada family
+-----------------
+
+  Armada 370 Flavors:
+        88F6710
+        88F6707
+        88F6W11
+
+  Armada XP Flavors:
+        MV78230
+        MV78260
+        MV78460
+  Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
+  Core: Sheeva ARMv7 compatible
+
+  Linux kernel directory: arch/arm/mach-mvebu
+  No public datasheet available.
+
+Avanta family
+-------------
+
+  Flavors:
+       88F6510
+       88F6530P
+       88F6550
+       88F6560
+  Homepage     : http://www.marvell.com/broadband/
+  Product Brief: http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
+  Core: ARMv5 compatible
+  Linux kernel directory: no code in mainline yet, planned for the future
+  No public datasheet available.
+
+Dove family (application processor)
+-----------------------------------
+
+  Flavors:
+        88AP510 a.k.a Armada 510
+                Product Brief   : http://www.marvell.com/application-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
+                Hardware Spec   : http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Hardware-Spec.pdf
+                Functional Spec : http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
+  Homepage: http://www.marvell.com/application-processors/armada-500/
+  Core: ARMv7 compatible
+  Directory: arch/arm/mach-dove
+
+PXA 2xx/3xx/93x/95 family (application processor)
+-------------------------------------------------
+  Flavors:
+        PXA270, PXA271, PXA272
+             Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
+             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
+             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
+             Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
+             Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
+             Core: ARMv5 XScale core
+        PXA300, PXA310, PXA320
+             PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
+             PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
+             PXA 320 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
+             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
+             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
+             Specifications        : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
+             Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
+             Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+             Core: ARMv5 XScale core
+        PXA930, PXA935
+             Core: ARMv5 XScale core
+        PXA955
+             Core: ARMv7 PJ4 core
+   Comment: bought by Marvell from Intel in ~2006. Completely
+   different IPs than the previously listed Marvell SoCs.
+   Linux kernel directory: arch/arm/mach-pxa
+
+MMP/MMP2 family (communication processor)
+-----------------------------------------
+
+   Flavors:
+        PXA168, a.k.a Armada 168
+             Homepage             : http://www.marvell.com/application-processors/armada-100/armada-168.jsp
+             Product brief        : http://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
+             Hardware manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
+             Software manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
+             Specification update : http://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
+             Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
+             App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
+             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
+        PXA910
+             Homepage             : http://www.marvell.com/communication-processors/pxa910/
+             Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
+             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
+        MMP2, a.k.a Armada 610
+             Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
+             Core: ARMv7 compatible Sheeva PJ4 core
+   Linux kernel directory: arch/arm/mach-mmp
+
+Credits
+-------
+
+ Maen Suleiman <maen@marvell.com>
+ Lior Amsalem <alior@marvell.com>
+ Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
1.7.9.5
