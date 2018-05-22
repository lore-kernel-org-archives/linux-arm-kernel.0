From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 22 May 2018 11:40:28 +0200
Subject: [PATCH v2 02/16] arm64: dts: marvell: fix CP110 ICU node size
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Message-ID: <20180522094042.24770-3-miquel.raynal@bootlin.com>
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
index 48cad7919efa..9fa41c54f69c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -146,7 +146,7 @@
 
 		CP110_LABEL(icu): interrupt-controller at 1e0000 {
 			compatible = "marvell,cp110-icu";
-			reg = <0x1e0000 0x10>;
+			reg = <0x1e0000 0x440>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			msi-parent = <&gicp>;
-- 
2.14.1
