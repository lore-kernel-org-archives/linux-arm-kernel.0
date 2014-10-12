From: carlo@caione.org (Carlo Caione)
Date: Sun, 12 Oct 2014 16:54:38 +0200
Subject: [PATCH 2/3] ARM: meson: DTSI: Enable reset controller
In-Reply-To: <1413125679-24443-1-git-send-email-carlo@caione.org>
References: <1413125679-24443-1-git-send-email-carlo@caione.org>
Message-ID: <1413125679-24443-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the node for the reset controller in the DTSI.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index e6539ea..1ca864e 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -75,6 +75,12 @@
 			reg = <0xc1109900 0x8>;
 		};
 
+		reset_AO: reset at c8100040 {
+			#reset-cells = <1>;
+			compatible = "amlogic,meson6-rst-mgr-ao";
+			reg = <0xc8100040 0x4>;
+		};
+
 		uart_AO: serial at c81004c0 {
 			compatible = "amlogic,meson-uart";
 			reg = <0xc81004c0 0x14>;
-- 
1.9.1
