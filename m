From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:22 +0200
Subject: [PATCH 09/16] ARM: at91/dt: at91sam9n12ek: use stdout-path
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-10-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 6e067c8a3502..eab17fcace6d 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -14,7 +14,8 @@
 	compatible = "atmel,at91sam9n12ek", "atmel,at91sam9n12", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2";
+		bootargs = "root=/dev/mtdblock1 rw rootfstype=jffs2";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
