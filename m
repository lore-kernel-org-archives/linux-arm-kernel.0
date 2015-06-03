From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  3 Jun 2015 14:24:13 +0200
Subject: [PATCH v2 11/16] ARM: at91/dt: at91sam9x5ek: use stdout-path
In-Reply-To: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1433334258-14741-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index cc83a37a7311..d237c462dfc6 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -13,7 +13,8 @@
 	compatible = "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
+		bootargs = "root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
+		stdout-path = "serial0:115200n8";
 	};
 
 	ahb {
-- 
2.1.4
