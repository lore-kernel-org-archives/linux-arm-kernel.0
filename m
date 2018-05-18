From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:17 +0200
Subject: [PATCH 44/69] ARM: dts: iwg23s-sbc: Add EtherAVB support
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <b6ef074bcadf9f89295bc7ee19424714b6ffc4c8.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Define the iW-RainboW-G23S board dependent part of the
EtherAVB device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index d21baad9f0ad..e3585daafdd6 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -12,11 +12,12 @@
 	compatible = "iwave,g23s", "renesas,r8a77470";
 
 	aliases {
+		ethernet0 = &avb;
 		serial1 = &scif1;
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial1:115200n8";
 	};
 
@@ -26,6 +27,18 @@
 	};
 };
 
+&avb {
+	phy-handle = <&phy3>;
+	phy-mode = "gmii";
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+		micrel,led-mode = <1>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
-- 
2.11.0
