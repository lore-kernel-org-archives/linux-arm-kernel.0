From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed,  5 Mar 2014 01:03:08 +0100
Subject: [PATCH 1/3] ARM: dove: drop pinctrl PMU reg property
In-Reply-To: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393977790-29110-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Dove's pinctrl does require some PMU regs for muxing PMU
functions to MPP pins. Recently, a discussion started about consolidating
Power Management Unit (PMU) into a single DT node. As we don't want
anymore DT ABI in the way, drop the corresponding reg property from
pinctrl node now. The driver will derive the registers from existing
reg properties.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index b6fc27f8ed66..3b891dd20993 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -395,8 +395,7 @@
 			pinctrl: pin-ctrl at d0200 {
 				compatible = "marvell,dove-pinctrl";
 				reg = <0xd0200 0x14>,
-				      <0xd0440 0x04>,
-				      <0xd802c 0x08>;
+				      <0xd0440 0x04>;
 				clocks = <&gate_clk 22>;
 
 				pmx_gpio_0: pmx-gpio-0 {
-- 
1.8.5.3
