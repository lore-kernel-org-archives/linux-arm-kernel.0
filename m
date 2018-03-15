From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu, 15 Mar 2018 15:17:14 +0800
Subject: [PATCH] ARM: dts: rockchip: fix uart4 pin-num for rk3288
Message-ID: <20180315071714.11589-1-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to TRM, uart4 tx/rx should be 14/15

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ed05f3d77358..40327c764385 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1938,16 +1938,16 @@
 
 		uart4 {
 			uart4_xfer: uart4-xfer {
-				rockchip,pins = <5 12 3 &pcfg_pull_up>,
-						<5 13 3 &pcfg_pull_none>;
+				rockchip,pins = <5 15 3 &pcfg_pull_up>,
+						<5 14 3 &pcfg_pull_none>;
 			};
 
 			uart4_cts: uart4-cts {
-				rockchip,pins = <5 14 3 &pcfg_pull_up>;
+				rockchip,pins = <5 12 3 &pcfg_pull_up>;
 			};
 
 			uart4_rts: uart4-rts {
-				rockchip,pins = <5 15 3 &pcfg_pull_none>;
+				rockchip,pins = <5 13 3 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.16.1
