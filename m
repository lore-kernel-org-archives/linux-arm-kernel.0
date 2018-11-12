From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:11 +0100
Subject: [PATCH v3 02/18] DT: marvell, mmp2: fix the gpio interrupt cell number
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-pxa uses two cell to encode the interrupt source: the pin number
and the trigger type. Adjust the device node accordingly.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..db15d1186cd0 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -180,7 +180,7 @@
 				clocks = <&soc_clocks MMP2_CLK_GPIO>;
 				resets = <&soc_clocks MMP2_CLK_GPIO>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				ranges;
 
 				gcb0: gpio at d4019000 {
-- 
2.19.1
