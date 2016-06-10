From: carlo@caione.org (Carlo Caione)
Date: Fri, 10 Jun 2016 21:44:11 +0200
Subject: [PATCH v7 3/3] ARM64: dts: amlogic: gxbb: Enable secure monitor
In-Reply-To: <1465587851-24184-1-git-send-email-carlo@caione.org>
References: <1465587851-24184-1-git-send-email-carlo@caione.org>
Message-ID: <1465587851-24184-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the secure monitor node in the Amlogic Meson GXBB DTSI file to
enable it.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 76b3b6d..092f10e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -123,6 +123,12 @@
 		#size-cells = <2>;
 		ranges;
 
+		firmware {
+			sm: secure-monitor {
+				compatible = "amlogic,meson-gxbb-sm";
+			};
+		};
+
 		cbus: cbus at c1100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc1100000 0x0 0x100000>;
-- 
2.7.4
