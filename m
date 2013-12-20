From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 20 Dec 2013 11:47:10 -0700
Subject: [PATCH V2 4/7] ARM: dts: imx6qdl: use interrupts-extended for fec
In-Reply-To: <1387565233-16144-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387565233-16144-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387565233-16144-5-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to be able to override interrupts in board file to
workaround a hardware bug for ethernet interrupts
waking the processor by using interrupts-extended.
So, use interrupts-extended here as well.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 09c3587..5b6cfeb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -738,8 +738,9 @@
 			fec: ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
-				interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 119 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended =
+					<&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
+					<&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks 117>, <&clks 117>, <&clks 190>;
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
-- 
1.8.1.2
