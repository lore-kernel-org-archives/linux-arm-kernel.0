From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:32 +0200
Subject: [PATCH 09/13] ARM: dts: iwg23s-sbc: specify EtherAVB PHY IRQ
In-Reply-To: <cover.1536824376.git.horms+renesas@verge.net.au>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
Message-ID: <938fbd1ae2aca6e0547411687f0cc32d18427eae.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Specify  EtherAVB PHY IRQ  in the board specific device tree, now that we
have GPIO support.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 56182eec81fb..22da819f186b 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -35,6 +35,8 @@
 
 	phy3: ethernet-phy at 3 {
 		reg = <3>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		micrel,led-mode = <1>;
 	};
 };
-- 
2.11.0
