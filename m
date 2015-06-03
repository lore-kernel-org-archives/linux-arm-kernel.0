From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  3 Jun 2015 14:24:12 +0200
Subject: [PATCH v2 10/16] ARM: at91/dt: at91sam9rlek: use stdout-path
In-Reply-To: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1433334258-14741-11-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rlek.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 724b9f54a60a..558c9f220bed 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -13,7 +13,8 @@
 	compatible = "atmel,at91sam9rlek", "atmel,at91sam9rl", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 rootfstype=ubifs root=ubi0:rootfs ubi.mtd=5 rw";
+		bootargs = "rootfstype=ubifs root=ubi0:rootfs ubi.mtd=5 rw";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
