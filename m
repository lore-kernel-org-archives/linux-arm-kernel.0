From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 24 Feb 2014 09:42:55 +0100
Subject: [PATCH 03/10] ARM: dove: add additional pinctrl registers
In-Reply-To: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393231382-11078-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove pinctrl uses additional registers to control MPPs. This patch first
increases existing pinctrl reg property by one register, and then adds
two new ranges for MPP4 and PMU MPP registers.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Rob Landley <rob@landley.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2b76524f4aa7..c5e90f0287b9 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -390,7 +390,9 @@
 
 			pinctrl: pin-ctrl at d0200 {
 				compatible = "marvell,dove-pinctrl";
-				reg = <0xd0200 0x10>;
+				reg = <0xd0200 0x14>,
+				      <0xd0440 0x04>,
+				      <0xd802c 0x08>;
 				clocks = <&gate_clk 22>;
 
 				pmx_gpio_0: pmx-gpio-0 {
-- 
1.8.5.3
