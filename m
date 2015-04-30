From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Thu, 30 Apr 2015 09:33:37 +0200
Subject: [PATCH v3 6/7] ARM: at91/dt: at91-kizbox: re-size nand partitions
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1430379218-13758-7-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-size NAND partitions since the bootstrap is able to read volumes from an
UBI image.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index b19f568..e739104 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -72,14 +72,14 @@
 			nand-ecc-mode = "soft";
 			status = "okay";
 
-			bootloaderkernel at 0 {
-				label = "bootloader-kernel";
-				reg = <0x0 0xc0000>;
+			bootstrap at 0 {
+				label = "bootstrap";
+				reg = <0x0 0x20000>;
 			};
 
-			ubi at c0000 {
+			ubi at 20000 {
 				label = "ubi";
-				reg = <0xc0000 0x7f40000>;
+				reg = <0x20000 0x7fe0000>;
 			};
 		};
 	};
-- 
1.9.1
