From: carlo@caione.org (Carlo Caione)
Date: Sun,  8 Nov 2015 13:18:57 +0100
Subject: [PATCH v3 4/4] ARM: dts: meson8b: Add watchdog node
In-Reply-To: <1446985137-25498-1-git-send-email-carlo@caione.org>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
Message-ID: <1446985137-25498-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

With this patch we add the watchdog node in the meson8b DTS file.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ee352bf..8bad557 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -105,6 +105,12 @@
 			#interrupt-cells = <3>;
 		};
 
+		wdt: watchdog at c1109900 {
+			compatible = "amlogic,meson8b-wdt";
+			reg = <0xc1109900 0x8>;
+			interrupts = <0 0 1>;
+		};
+
 		timer at c1109940 {
 			compatible = "amlogic,meson6-timer";
 			reg = <0xc1109940 0x18>;
-- 
1.9.1
