From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jan 2014 11:08:47 +0100
Subject: [PATCH v2] ARM: sun5i: a13: Add missing serial aliases
Message-ID: <1389607727-16755-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes from v1:
  - Changed the index of the aliases from serial1 and serial3 to serial0 and
    serial1

 arch/arm/boot/dts/sun5i-a13.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 4dee971..1536aa5 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -16,6 +16,11 @@
 / {
 	interrupt-parent = <&intc>;
 
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.4.2
