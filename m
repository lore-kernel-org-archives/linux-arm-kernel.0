From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:37 +0200
Subject: [PATCH 075/102] arm64: dts: renesas: r8a7795: salvator-xs: enable
 hsusb channel 3 node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <5650011a0607930b1691108ad66034aef1a75fa0.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables HS-USB channel3 node for r8a7795 with Salvator-XS.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 622b2a22ab0f..bbf5a8812b70 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -56,6 +56,11 @@
 	status = "okay";
 };
 
+&hsusb3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &sound_card {
 	dais = <&rsnd_port0	/* ak4613 */
 		&rsnd_port1	/* HDMI0  */
-- 
2.11.0
