From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  1 Jul 2014 15:04:30 +0200
Subject: [PATCH 3/4] ARM: dts: dove: enable lcd0 on SolidRun CuBox
In-Reply-To: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1404219871-18419-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

This enables lcd0 on SolidRun CuBox which is connected to TDA998x
HDMI transmitter. Also, set the external video clock connected to
Si5351 clock generator.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 7a70f4c..303a354 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -134,3 +134,9 @@
 	pinctrl-0 = <&pmx_audio1_i2s1_spdifo &pmx_audio1_extclk>;
 	pinctrl-names = "default";
 };
+
+&lcd0 {
+	status = "okay";
+	clocks = <&si5351 0>;
+	clock-names = "ext_ref_clk_1";
+};
-- 
1.7.2.5
