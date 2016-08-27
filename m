From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Aug 2016 15:43:45 +0200
Subject: [PATCH v3 3/6] ARM64: dts: amlogic: gxbb: Enable secure monitor
In-Reply-To: <1472305428-16874-1-git-send-email-carlo@caione.org>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
Message-ID: <1472305428-16874-4-git-send-email-carlo@caione.org>
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
index e502c24..ca428e8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -99,6 +99,12 @@
 		method = "smc";
 	};
 
+	firmware {
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.7.4
