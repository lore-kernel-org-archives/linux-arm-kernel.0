From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 21 Apr 2017 09:58:14 +1200
Subject: [PATCH 2/2] ARM: dts: mvebu: disable the rtc on 98dx3236 SoC
In-Reply-To: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz>
References: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170420215814.6817-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no rtc for the 98dx3236 and derivative SoCs. Disable the rtc
node inherited from the armada-370-xp base.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 84cc232a29e9..be22ec5236ac 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -311,6 +311,10 @@
 	reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 };
 
+&rtc {
+	status = "disabled";
+};
+
 &timer {
 	compatible = "marvell,armada-xp-timer";
 	clocks = <&coreclk 2>, <&refclk>;
-- 
2.11.0.24.ge6920cf
