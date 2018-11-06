From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 6 Nov 2018 09:19:41 +0000
Subject: [PATCH] ARM: dts: imx6sl: vddpu is NOT an always-on regulator
In-Reply-To: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
References: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1541495675-14706-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove "regulator-always-on" property for vddpu regulator
since it can be OFF when GPU power domain is OFF.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 9bbc5b0..557d3fd 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -588,7 +588,6 @@
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
 					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
 					anatop-reg-offset = <0x140>;
 					anatop-vol-bit-shift = <9>;
 					anatop-vol-bit-width = <5>;
-- 
2.7.4
