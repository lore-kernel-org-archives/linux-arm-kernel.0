From: carlo@caione.org (Carlo Caione)
Date: Wed, 17 Sep 2014 22:12:05 +0200
Subject: [PATCH v2 3/4] ARM: DTS: meson: update DTSI to add watchdog node
In-Reply-To: <1410984726-18944-1-git-send-email-carlo@caione.org>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
Message-ID: <1410984726-18944-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..ebe7742 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -70,6 +70,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		wdt: watchdog at c1109900 {
+			compatible = "amlogic,meson-wdt";
+			reg = <0xc1109900 0x8>;
+		};
+
 		uart_AO: serial at c81004c0 {
 			compatible = "amlogic,meson-uart";
 			reg = <0xc81004c0 0x14>;
-- 
1.9.1
