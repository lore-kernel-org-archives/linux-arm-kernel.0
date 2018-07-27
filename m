From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Fri, 27 Jul 2018 14:23:29 -0700
Subject: [PATCH v2 3/7] arm64: dts: Fix the base address of the Broadcom iProc
 mdio mux
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the base address of the mdio mux driver to point to the
start of the mdio mux block's register address space.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 4 ++--
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4057197..1a406a7 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -482,9 +482,9 @@
 			status = "disabled";
 		};
 
-		mdio_mux_iproc: mdio-mux at 6602023c {
+		mdio_mux_iproc: mdio-mux at 66020000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x6602023c 0x14>;
+			reg = <0x66020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b203152..a70e8dd 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -278,9 +278,9 @@
 
 		#include "stingray-pinctrl.dtsi"
 
-		mdio_mux_iproc: mdio-mux at 2023c {
+		mdio_mux_iproc: mdio-mux at 20000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x0002023c 0x14>;
+			reg = <0x00020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
1.9.1
