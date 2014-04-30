From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:35 +0200
Subject: [PATCH 08/15] ARM: dts: kirkwood: set default pinctrl for GBE1
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Kirkwood, there is only one valid pinctrl setting for GBE1. With
a common SoC pinctrl node, we can now set it in the node instead of
in each board file.

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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 2 --
 arch/arm/boot/dts/kirkwood.dtsi              | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index 1a7f18d5530d..622a3ca12c2d 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -207,8 +207,6 @@
 
 &eth1 {
 	status = "okay";
-	pinctrl-0 = <&pmx_ge1>;
-	pinctrl-names = "default";
 	ethernet1-port at 0 {
 		phy-handle = <&ethphy1>;
 	};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 5d412e71b9fb..fff28b71b474 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -320,6 +320,8 @@
 			reg = <0x76000 0x4000>;
 			clocks = <&gate_clk 19>;
 			marvell,tx-checksum-limit = <1600>;
+			pinctrl-0 = <&pmx_ge1>;
+			pinctrl-names = "default";
 			status = "disabled";
 
 			ethernet1-port at 0 {
-- 
1.9.1
