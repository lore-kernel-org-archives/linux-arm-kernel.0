From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:38 +0200
Subject: [PATCH 076/102] arm64: dts: renesas: r8a7795: salvator-xs: enable
 USB2.0 host channel 3
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <610fd5deb11ab0ec0af318e0912da8b1dcb5637d.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables USB2.0 host channel 3 for r8a7795 with Salvator-XS.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index bbf5a8812b70..e231b5a7cbab 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -56,6 +56,11 @@
 	status = "okay";
 };
 
+&ehci3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &hsusb3 {
 	dr_mode = "otg";
 	status = "okay";
@@ -117,6 +122,11 @@
 	status = "okay";
 };
 
+&ohci3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &rcar_sound {
 	ports {
 		/* rsnd_port0 is on salvator-common */
-- 
2.11.0
