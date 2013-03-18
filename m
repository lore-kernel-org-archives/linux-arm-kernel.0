From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:31 +0900
Subject: [PATCH 39/43] ARM: shmobile: r8a7779: add Thermal support on DT
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-40-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

76cc1887496fe80138c6b07c37d7f81e4cf27cde
(thermal: rcar: add Device Tree support)
supported rcar_thermal DT probing.

rcar thermal driver doesn't support IRQ on r8a7779 chip
since it is using old design IRQ.
R-Car/R-Mobile next generation chips are using new design IRQ,
and rcar thermal driver is supporting these.

This patch adds rcar_thermal DT support for r8a7779 without IRQ.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index c73eb37..18383db 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -83,4 +83,9 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
 	};
+
+	thermal at ffc48000 {
+		compatible = "renesas,rcar-thermal";
+		reg = <0xffc48000 0x38>;
+	};
 };
-- 
1.7.10.4
