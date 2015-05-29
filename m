From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:25 +0200
Subject: [PATCH 12/16] ARM: at91/dt: sama5d3xek: use stdout-path
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-13-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument from
the kernel command line.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index ef404e907026..2cf9c3611db6 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -11,7 +11,8 @@
 	compatible = "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs";
+		bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4
