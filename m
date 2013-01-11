From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 15:45:28 +0000
Subject: [PATCH 1/2] ARM: ux500: Provide a link from AB8500 Pinctrl to the
 PRCMU
Message-ID: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AB8500 Pinctrl driver uses PRCMU register addresses to
control Pinctrl related functions. For this to happen, the
Pinctrl driver needs the PRCMU base to work from. We can do
that using standard Open Firmware (of_*) function calls, but
first we need a mechanism to gain access to the PRCMU
device node. We're going to use a Phandle in this case.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index db69f3c..3381ba6 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -170,10 +170,9 @@
 			gpio-bank = <8>;
 		};
 
-		pinctrl at 80157000 {
-			// This is actually the PRCMU base address
-			reg = <0x80157000 0x2000>;
+		pinctrl {
 			compatible = "stericsson,nmk_pinctrl";
+			prcm = <&prcmu>;
 		};
 
 		usb at a03e0000 {
@@ -190,7 +189,7 @@
 			interrupts = <0 25 0x4>;
 		};
 
-		prcmu at 80157000 {
+		prcmu: prcmu at 80157000 {
 			compatible = "stericsson,db8500-prcmu";
 			reg = <0x80157000 0x2000>;
 			interrupts = <0 47 0x4>;
-- 
1.7.9.5
