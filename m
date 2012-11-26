From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 26 Nov 2012 10:18:44 +0100
Subject: [PATCH 1/2] ARM: Dove: Add pinctrl clock to DT
In-Reply-To: <20121125152845.GV15800@titan.lakedaemon.net>
References: <20121125152845.GV15800@titan.lakedaemon.net>
Message-ID: <1353921525-25163-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During merge of the mvebu patches a clock gate for pinctrl was
lost. This patch just readds the clock gate.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/dove.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index f3f7e9d..42eac1f 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -117,6 +117,7 @@
 		pinctrl: pinctrl at d0200 {
 			compatible = "marvell,dove-pinctrl";
 			reg = <0xd0200 0x10>;
+			clocks = <&gate_clk 22>;
 		};
 
 		spi0: spi at 10600 {
-- 
1.7.10.4
