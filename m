From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:21 +0200
Subject: [PATCH 08/16] ARM: at91/dt: at91sam9m10g45ek use stdout-path
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 33ce7ca2c404..1375d3362603 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -15,7 +15,8 @@
 	compatible = "atmel,at91sam9m10g45ek", "atmel,at91sam9g45", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2";
+		bootargs = "mem=64M root=/dev/mtdblock1 rw rootfstype=jffs2";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
