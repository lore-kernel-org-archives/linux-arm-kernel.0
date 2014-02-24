From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 24 Feb 2014 11:25:56 +0100
Subject: [PATCH 2/3] dts: mpc512x: adjust clock specs for FEC nodes
In-Reply-To: <1393237557-31406-1-git-send-email-gsi@denx.de>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
Message-ID: <1393237557-31406-2-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a recent FEC binding document update that was motivated by i.MX
development revealed that ARM and PowerPC implementations in Linux
did not agree on the clock names to use for the FEC nodes

change clock names from "per" to "ipg" in the FEC nodes of the
mpc5121.dtsi include file such that the .dts specs comply with
the common FEC binding

this "incompatible" change does not break operation, because
- COMMON_CLK support for MPC5121/23/25 and adjusted .dts files
  were only introduced in Linux v3.14-rc1, no mainline release
  provided these specs before
- if this change won't make it for v3.14, the MPC512x CCF support
  provides full backwards compability, and keeps operating with
  device trees which lack clock specs or don't match in the names

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/mpc5121.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 2c0e1552d20b..a5a375598ed8 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -281,7 +281,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clks MPC512x_CLK_FEC>;
-			clock-names = "per";
+			clock-names = "ipg";
 		};
 
 		eth0: ethernet at 2800 {
@@ -291,7 +291,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <4 0x8>;
 			clocks = <&clks MPC512x_CLK_FEC>;
-			clock-names = "per";
+			clock-names = "ipg";
 		};
 
 		/* USB1 using external ULPI PHY */
-- 
1.7.10.4
