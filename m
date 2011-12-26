From: yanok@emcraft.com (Ilya Yanok)
Date: Tue, 27 Dec 2011 00:08:31 +0100
Subject: [PATCH 1/2] mt_ventoux: very basic support for TeeJet Mt.Ventoux board
In-Reply-To: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
Message-ID: <1324940912-18164-2-git-send-email-yanok@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Very basic support for TeeJet Mt.Ventoux board. Able to boot via
board-generic and ramdisk/initramfs, however most of peripherals are
not supported. Produces tons of twl4030 related errors as this board
doesn't have twl4030 installed.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/boot/dts/am3517_mt_ventoux.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517_mt_ventoux.dts

diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
new file mode 100644
index 0000000..5eb26d7
--- /dev/null
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	model = "TeeJet Mt.Ventoux";
+	compatible = "teejet,mt_ventoux", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	/* AM35xx doesn't have IVA */
+	soc {
+		iva {
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.6.4
