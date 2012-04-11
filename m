From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 18:01:16 +0200
Subject: [PATCH 6/9] ARM: at91: DT: add Calao USB A9260 DT support
In-Reply-To: <20120411153515.GK16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
Message-ID: <1334160079-30831-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/usb_a9260.dts  |   23 +++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/usb_a9260.dts

diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/usb_a9260.dts
new file mode 100644
index 0000000..2962160
--- /dev/null
+++ b/arch/arm/boot/dts/usb_a9260.dts
@@ -0,0 +1,23 @@
+/*
+ * usb_a9260.dts - Device Tree file for Caloa USB A9260 board
+ *
+ *  Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+/include/ "at91sam9260.dtsi"
+/include/ "usb_a9260_common.dtsi"
+
+/ {
+	model = "Calao USB A9260";
+	compatible = "calao,usb-a9260", "atmel,at91sam9260", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
+	};
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 30d6c10..b2ac536 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -16,6 +16,7 @@ endif
 # Keep dtb files sorted alphabetically for each SoC
 # sam9260
 dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9260.dtb
 # sam9g20
 dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek.dtb
 dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek_2mmc.dtb
-- 
1.7.9.1
