From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 27 Mar 2013 22:03:18 +0100
Subject: [PATCH 1/3] ARM: ux500: Apply the TCPM and TCDM locations and sizes
 to dbx5x0 DT
In-Reply-To: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
References: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1364418200-15628-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

This fixes a regression introduced by commit:
  05ec260 mfd:db8500-prcmu: update resource passing

All DBx5x0 based SoCs have access to two Tightly Coupled Memory
(TCM) locations based on the PRCMU itself. One area from program
memory (TCPM) and one for data memory (TCDM). The PRCMU needs to
know where these are in order to function correctly. However,
these are currently passed though platform device resources, which
can only be obtained if Device Tree booting isn't in use. Thus we
must also support them in DT by supplying them through the PRCMU
node.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9de9309..aaa63d0 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -191,8 +191,8 @@
 
 		prcmu: prcmu at 80157000 {
 			compatible = "stericsson,db8500-prcmu";
-			reg = <0x80157000 0x1000>;
-			reg-names = "prcmu";
+			reg = <0x80157000 0x1000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
+			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
 			interrupts = <0 47 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.11.3
