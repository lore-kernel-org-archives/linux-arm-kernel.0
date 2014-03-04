From: mohit.kumar@st.com (Mohit Kumar)
Date: Tue, 4 Mar 2014 11:11:20 +0530
Subject: [PATCH V7 07/10 resend] SPEAr13XX: dts: Add PCIe node information
In-Reply-To: <cover.1393568715.git.mohit.kumar@st.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
Message-ID: <b02c2cf599817a852e0cdb2e24e76e74da02637d.1393568715.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr1310 and SPEAr1340 supports 3 and 1 PCIe controller respectively.
These controllers are based on synopsys designware controller.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
---
Fixed interrupt-map property as per new discussion.
http://www.spinics.net/lists/arm-kernel/msg312036.html

 arch/arm/boot/dts/spear1310.dtsi |   48 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340.dtsi |   16 ++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 64e7dd5..136a12d 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -83,6 +83,54 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie at b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 68 0x4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie1: pcie at b1800000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1800000 0x4000>;
+			interrupts = <0 69 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 69 0x4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x90000000 0x90000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x90030000 0x90030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie2: pcie at b4000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb4000000 0x4000>;
+			interrupts = <0 70 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 70 0x4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0xc0000000 0xc0000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0xc0030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
 		gmac1: eth at 5c400000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c400000 0x8000>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index b8b32c7..9af299d 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -48,6 +48,22 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie at b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 68 0x4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
 		i2s-play at b2400000 {
 			compatible = "snps,designware-i2s";
 			reg = <0xb2400000 0x10000>;
-- 
1.7.0.1
