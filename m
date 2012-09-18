From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Sep 2012 17:52:28 +0200
Subject: [PATCH 1/1] ARM: ux500: Fix SSP register address format
Message-ID: <1347983548-15243-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SSP won't probe unless the specified register address format
is correct i.e. we have to specify that the address is in hex.
After this patch has been applied, the SSP (SPI) driver probes
as expected.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 3708a6b..748ba7a 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -536,7 +536,7 @@
 
 		ssp at 80002000 {
 			compatible = "arm,pl022", "arm,primecell";
-			reg = <80002000 0x1000>;
+			reg = <0x80002000 0x1000>;
 			interrupts = <0 14 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.9.5
