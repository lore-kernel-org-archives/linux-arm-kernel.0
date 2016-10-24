From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Mon, 24 Oct 2016 12:12:04 -0700
Subject: [PATCH v1 3/3] ARM: dts: Add node for Broadcom OTP controller driver
In-Reply-To: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1477336324-10543-4-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathar@broadcom.com>

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Oza Pawandeep <oza@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index fabc9f3..a74a430 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -91,6 +91,13 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		otp: otp at 0301c800 {
+			compatible = "brcm,ocotp";
+			reg = <0x0301c800 0x2c>;
+			brcm,ocotp-size = <2048>;
+			status = "disabled";
+		};
+
 		pcie_phy: phy at 0301d0a0 {
 			compatible = "brcm,cygnus-pcie-phy";
 			reg = <0x0301d0a0 0x14>;
-- 
1.9.1
