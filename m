From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 14 Dec 2015 20:11:42 +0100
Subject: [PATCH/RFC 5/7] ARM: shmobile: porter dts: Add compatible property to
 "partitions" node
In-Reply-To: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
References: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1450120304-2760-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The abovementioned commit is destined for v4.4.
---
 arch/arm/boot/dts/r8a7791-porter.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index b93016896378c350..f8d8e2e2169a9c40 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -213,6 +213,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
1.9.1
