From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  7 Jun 2016 19:59:10 +0200
Subject: [PATCH] ARM: dts: at91: usb_a9g20: use stdout-path
Message-ID: <1465322350-14079-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/usb_a9g20_common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/usb_a9g20_common.dtsi
index 0b3b36182fe5..6156ee878345 100644
--- a/arch/arm/boot/dts/usb_a9g20_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
@@ -11,7 +11,8 @@
 
 / {
 	chosen {
-		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
+		bootargs = "mem=64M root=/dev/mtdblock5 rw rootfstype=ubifs";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.8.1
