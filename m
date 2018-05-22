From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 22 May 2018 21:57:57 +0200
Subject: [PATCH] arm64: dts: fix regulator property name for wlan pcie endpoint
Message-ID: <20180522195758.24607-1-niklas.cassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property name vddpe-supply is not included in
Documentation/devicetree/bindings/pci/qcom,pcie.txt
nor in the pcie-qcom PCIe Root Complex driver.

This property name was used in an initial patchset for pcie-qcom,
but was renamed in a later revision.

Therefore, the regulator is currently never enabled, leaving us with
unoperational wlan.

Fix this by using the correct regulator property name, so that wlan
comes up correctly.

Fixes: 1c8ca74a2ea1 ("arm64: dts: apq8096-db820c: Enable wlan and bt en pins")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Bluetooth needs a similar patch, but since bluetooth needs some more
work, submit this right now, so we at least have working wlan.

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 818bf0efd501..804268f54f37 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -203,7 +203,7 @@
 			pcie at 600000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-				vddpe-supply = <&wlan_en>;
+				vddpe-3v3-supply = <&wlan_en>;
 				vddpe1-supply = <&bt_en>;
 			};
 
-- 
2.17.0
