From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:28 +0200
Subject: [PATCH 15/16] ARM: at91/dt: sama5d4 xplained: use stdout-path
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-16-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 5dbc0fcfc5a8..22ad7c959103 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -50,7 +50,8 @@
 	compatible = "atmel,sama5d4-xplained", "atmel,sama5d4", "atmel,sama5";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 ignore_loglevel earlyprintk";
+		bootargs = "ignore_loglevel earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
