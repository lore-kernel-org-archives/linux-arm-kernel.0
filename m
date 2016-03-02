From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed,  2 Mar 2016 11:29:13 -0500
Subject: [PATCH] ARM: dts: imx: ba16: Add correct PCIe Tx Values
Message-ID: <1456936153-6386-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Waters <justin.waters@timesys.com>

Utilize the new PCIe Tx configuration to properly support the correct
values.

Signed-off-by: Justin Waters <justin.waters@timesys.com>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---

Hi Shawn,

A patch for setting PCIe PHY properties in imx6 GPR8 register has been accepted
and is in PCIe maintainers git tree.
https://patchwork.ozlabs.org/patch/568166/

Updating the ba16 based boards to set the correct tx-swing values.

Thanks,
Akshay

 arch/arm/boot/dts/imx6q-ba16.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 8f6e603..fcc7b50 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -323,6 +323,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+	fsl,tx-swing-full = <103>;
+	fsl,tx-swing-low = <103>;
 	status = "okay";
 };
 
-- 
2.7.2
