From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 21 Dec 2015 11:33:48 +0100
Subject: [PATCH v2 4/9] ARM: shmobile: lager dts: Add compatible property to
 "partitions" node
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1450694033-27717-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 7773cb1f10317d85..cdc0414f5f0716dd 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -457,6 +457,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
1.9.1
