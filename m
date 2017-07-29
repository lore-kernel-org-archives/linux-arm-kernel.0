From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:27 +0530
Subject: [PATCH 5/7] arm64: dts: Add SATA DT nodes for Stingray SoC
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-6-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

Add DT nodes for SATA host controllers and SATA PHYs
on Stingray SoC

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi |  64 +++++
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 278 +++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   2 +
 3 files changed, 344 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index cacc25e..8862ec9 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -72,6 +72,70 @@
 	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
 };
 
+&sata0 {
+	status = "okay";
+};
+
+&sata_phy0{
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata_phy1{
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata_phy2{
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
+
+&sata_phy3{
+	status = "okay";
+};
+
+&sata4 {
+	status = "okay";
+};
+
+&sata_phy4{
+	status = "okay";
+};
+
+&sata5 {
+	status = "okay";
+};
+
+&sata_phy5{
+	status = "okay";
+};
+
+&sata6 {
+	status = "okay";
+};
+
+&sata_phy6{
+	status = "okay";
+};
+
+&sata7 {
+	status = "okay";
+};
+
+&sata_phy7{
+	status = "okay";
+};
+
 &mdio_mux_iproc {
 	mdio at 10 {
 		gphy0: eth-phy at 10 {
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
new file mode 100644
index 0000000..a774709
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
@@ -0,0 +1,278 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2016-2017 Broadcom.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+	sata {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x67d00000 0x00800000>;
+
+		sata0: ahci at 00210000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00210000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata0_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy0: sata_phy at 00212100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00212100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata1: ahci at 00310000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00310000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata1_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata1_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy1: sata_phy at 00312100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00312100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata1_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata2: ahci at 00120000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00120000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata2_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata2_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy2: sata_phy at 00122100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00122100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata2_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata3: ahci at 00130000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00130000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata3_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata3_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy3: sata_phy at 00132100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00132100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata3_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata4: ahci at 00330000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00330000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata4_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata4_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy4: sata_phy at 00332100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00332100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata4_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata5: ahci at 00400000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00400000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata5_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata5_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy5: sata_phy at 00402100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00402100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata5_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata6: ahci at 00410000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00410000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata6_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata6_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy6: sata_phy at 00412100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00412100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata6_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+
+		sata7: ahci at 00420000 {
+			compatible = "brcm,iproc-ahci", "generic-ahci";
+			reg = <0x00420000 0x1000>;
+			reg-names = "ahci";
+			interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata7_port0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata7_phy0>;
+				phy-names = "sata-phy";
+			};
+		};
+
+		sata_phy7: sata_phy at 00422100 {
+			compatible = "brcm,iproc-sr-sata-phy";
+			reg = <0x00422100 0x1000>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata7_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 1c6cc2d..1700033 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -267,6 +267,8 @@
 		};
 	};
 
+	#include "stingray-sata.dtsi"
+
 	hsls {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
