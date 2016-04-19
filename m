From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Tue, 19 Apr 2016 12:30:01 -0400
Subject: [PATCH] ARM: dts: imx6q-ba16: use wdog external reset
Message-ID: <1461083401-12662-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BA16 module has a PMIC that uses the WDOG_B output from iMX6 to
reset the system on a watchdog timeout. Configure the watchdog to assert
the external reset signal (WDOG_B) using fsl,ext-reset-output property.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---

Hi Shawn,

The imx watchdog external reset patch has made it to the maintainers git tree:
https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/commit/?h=watchdog-next&id=5b25ce9e897fdd7bcd9ca47c5aa63ad2095d1ada

Adding fsl,ext-reset-output property to the BA16 module.

Thanks,
Akshay

 arch/arm/boot/dts/imx6q-ba16.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 7c80a1e..b4dd2be 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -400,6 +400,7 @@
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
 };
 
 &iomuxc {
-- 
2.8.1
