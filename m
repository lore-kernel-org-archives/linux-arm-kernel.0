From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:27 +0200
Subject: [PATCH 14/16] ARM: at91/dt: sama5d4ek: use stdout-path
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-15-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 89ef4a540db5..c8be7f82cf8c 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -50,7 +50,8 @@
 	compatible = "atmel,sama5d4ek", "atmel,sama5d4", "atmel,sama5";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 ignore_loglevel earlyprintk";
+		bootargs = "ignore_loglevel earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
