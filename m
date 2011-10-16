From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 23:18:13 +0200
Subject: [PATCH 2/4] ARM: at91: add Calao USB A9G20 DT support
In-Reply-To: <20111016210819.GM1459@game.jcrosoft.org>
References: <20111016210819.GM1459@game.jcrosoft.org>
Message-ID: <1318799895-5121-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/usb_a9g20.dts  |   45 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot |    2 +-
 arch/arm/mach-at91/board-dt.c    |    1 +
 3 files changed, 47 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/usb_a9g20.dts

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
new file mode 100644
index 0000000..4432a29
--- /dev/null
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -0,0 +1,45 @@
+/*
+ * usb_a9g20.dts - Device Tree file for Caloa USB A9G20 board
+ *
+ *  Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+/include/ "at91sam9g20.dtsi"
+
+/ {
+	model = "Calao USB A9G20";
+	compatible = "calao,usb-a9g20", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 mtdparts=atmel_nand:4M(bootstrap/uboot/kernel)ro,60M(rootfs),-(data) root=/dev/mtdblock1 rw rootfstype=jffs2";
+	};
+
+	memory at 70000000 {
+		reg = <0x20000000 0x4000000>;
+	};
+
+	ahb {
+		apb {
+			usart0: serial at fffb0000 {
+				status = "disabled";
+			};
+			usart1: serial at fffb4000 {
+				status = "disabled";
+			};
+			usart2: serial at fffb8000 {
+				status = "disabled";
+			};
+			usart3: serial at fffd0000 {
+				status = "disabled";
+			};
+			usart4: serial at fffd4000 {
+				status = "disabled";
+			};
+			usart5: serial at fffd8000 {
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index d278863..08c665a 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -17,4 +17,4 @@ params_phys-y	:= 0x20000100
 initrd_phys-y	:= 0x20410000
 endif
 
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb usb_a9g20.dtb
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 066d362..fdcbf72 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -108,6 +108,7 @@ static void __init at91_dt_device_init(void)
 
 static const char *at91_dt_board_compat[] __initdata = {
 	"atmel,at91sam9m10g45ek",
+	"calao,usb-a9g20",
 	NULL
 };
 
-- 
1.7.7
