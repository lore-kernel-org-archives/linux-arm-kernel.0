From: carlo@caione.org (Carlo Caione)
Date: Sun, 19 Jun 2016 14:39:04 +0200
Subject: [PATCH 6/6] ARM64: dts: amlogic: gxbb: Enable NVMEM
In-Reply-To: <1466339944-602-1-git-send-email-carlo@caione.org>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
Message-ID: <1466339944-602-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the NVMEM device node in the DTSI.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 407f24c..0e0f7c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -104,6 +104,24 @@
 		};
 	};
 
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sn: sn at 14 {
+			reg = <0x14 0x10>;
+		};
+
+		eth_mac: eth_mac at 34 {
+			reg = <0x34 0x10>;
+		};
+
+		bid: bid at 46 {
+			reg = <0x46 0x30>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.7.4
