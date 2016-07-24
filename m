From: johan@kernel.org (Johan Hovold)
Date: Sun, 24 Jul 2016 14:10:59 +0200
Subject: [PATCH 2/3] ARM: dts: overo: fix gpmc nand cs0 range
In-Reply-To: <1469362260-20066-1-git-send-email-johan@kernel.org>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
Message-ID: <1469362260-20066-3-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpmc ranges property for NAND at CS0 has been broken since it was
first added.

This currently prevents the nand gpmc child node from being probed:

	omap-gpmc 6e000000.gpmc: /ocp/gpmc at 6e000000/nand at 0,0 has
	malformed 'reg' property

and consequently the NAND device from being registered.

Fixes: 98ce6007efb4 ("ARM: dts: overo: Support PoP NAND")
Cc: stable <stable@vger.kernel.org>	# 4.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index de256fa8da48..b15c435439fb 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -223,7 +223,7 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>;
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 */
 
 	nand at 0,0 {
 		compatible = "ti,omap2-nand";
-- 
2.7.3
