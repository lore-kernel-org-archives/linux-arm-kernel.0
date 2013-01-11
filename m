From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 10:43:49 +0000
Subject: [PATCH] ARM: ux500: Include the PRCMU's Secure Registers in DB8500's
 DT
Message-ID: <1357901029-9073-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only include the PRCMU's primary registers when
referencing the register count in the 'reg' property. This patch
expands that count to include the secure registers also.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 2efd9c8..337c3b9 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -190,7 +190,7 @@
 
 		prcmu at 80157000 {
 			compatible = "stericsson,db8500-prcmu";
-			reg = <0x80157000 0x1000>;
+			reg = <0x80157000 0x2000>;
 			interrupts = <0 47 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.9.5
