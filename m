From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Jan 2014 01:39:15 +0100
Subject: [PATCH v2 03/21] ARM: dove: add additional pinctrl registers
In-Reply-To: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390869573-27624-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove pinctrl used additional registers to control MPPs. This patch first
increases existing pinctrl reg property by one register, and then adds
two new ranges for MPP4 and PMU MPP registers.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 8de1031233ae..69405e00f2c8 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -392,7 +392,9 @@
 
 			pinctrl: pin-ctrl at d0200 {
 				compatible = "marvell,dove-pinctrl";
-				reg = <0xd0200 0x10>;
+				reg = <0xd0200 0x14>,
+				      <0xd0440 0x04>,
+				      <0xd802c 0x08>;
 				clocks = <&gate_clk 22>;
 
 				pmx_gpio_0: pmx-gpio-0 {
-- 
1.8.5.2
