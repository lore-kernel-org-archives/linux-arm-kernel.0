From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri,  1 Dec 2017 08:41:23 +0100
Subject: [PATCH v4 2/2] DTS: Pandora: fix panel compatibility string
In-Reply-To: <cover.1512114082.git.hns@goldelico.com>
References: <cover.1512114082.git.hns@goldelico.com>
Message-ID: <d40df807bb7f890102578e596b3ab84f4ffb11c3.1512114082.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove the unnecessary "omapdss," prefix because
the omapdrm driver takes care of it when matching with
the driver table.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 53e007abdc71..64d967ec8c58 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -626,7 +626,7 @@
 
 	lcd: lcd at 1 {
 		reg = <1>;	/* CS1 */
-		compatible =	"omapdss,tpo,td043mtea1";
+		compatible =	"tpo,td043mtea1";
 		spi-max-frequency = <100000>;
 		spi-cpol;
 		spi-cpha;
-- 
2.12.2
