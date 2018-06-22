From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 22 Jun 2018 17:14:18 +0200
Subject: [PATCH v3 03/17] arm64: dts: marvell: fix CP110 ICU node size
In-Reply-To: <20180622151432.1566-1-miquel.raynal@bootlin.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
Message-ID: <20180622151432.1566-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
specification).

Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
Cc: stable at vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 7dabe25f6774..1c6ff8197a88 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -149,7 +149,7 @@
 
 		CP110_LABEL(icu): interrupt-controller at 1e0000 {
 			compatible = "marvell,cp110-icu";
-			reg = <0x1e0000 0x10>;
+			reg = <0x1e0000 0x440>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			msi-parent = <&gicp>;
-- 
2.14.1
