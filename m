From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu,  1 Nov 2012 21:57:01 +0000
Subject: [PATCH V2] ARM: kirkwood: Increase NAND chip-delay for DNS-32[05]
In-Reply-To: <20121030060226.GA14093@lunn.ch>
References: <20121030060226.GA14093@lunn.ch>
Message-ID: <1351807021-17478-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default chip-delay of 25us is a bit too tight for some DNS-320's,
and D-Link seem to specify 30us in their kernels for both devices.
Increase to 35us to make sure the NAND is stable.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index e0e4397..0360361 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -48,6 +48,7 @@
 
 		nand at 3000000 {
 			status = "okay";
+			chip-delay = <35>;
 
 			partition at 0 {
 				label = "u-boot";
-- 
1.7.10.4
