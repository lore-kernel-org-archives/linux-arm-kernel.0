From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:34 +0200
Subject: [PATCH 31/31] arm64: dts: renesas: salvator-common: add dr_mode
 property for USB2.0 channel 0
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <e9ce35386b215d3f5d0fbab3cc24b69b8d57d7e6.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since Salvator-X[S] have a USB2.0 dual-role channel (CN9), this patch
adds dr_mode property for USB2.0 channel 0 (EHCI/OHCI and HS-USB)
as "otg".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index c883e46c06ac..2fbb6e3b5dbe 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -272,6 +272,7 @@
 };
 
 &ehci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -284,6 +285,7 @@
 };
 
 &hsusb {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -346,6 +348,7 @@
 };
 
 &ohci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
2.11.0
