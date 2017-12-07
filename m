From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:19 +0100
Subject: [PATCH 16/54] arm64: dts: renesas: ulcb-kf: add dr_mode property for
 USB2.0 channel 0
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <499468cf063923dbcbab92c4916b6183348c551f.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

ULCB-KF has a USB2.0 dual-role channel (CN13).
This adds dr_mode property for USB2.0 channel 0 (EHCI/OHCI and HS-USB)
as "otg".

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 48a2e8f48e3f..a4e715cbde87 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -29,6 +29,7 @@
 };
 
 &ehci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -41,6 +42,7 @@
 };
 
 &hsusb {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -133,6 +135,7 @@
 };
 
 &ohci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
2.11.0
