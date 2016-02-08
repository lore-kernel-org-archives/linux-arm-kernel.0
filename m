From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:16 -0600
Subject: [PATCH V2 11/12] dtb: amd: Add support for new AMD Overdrive boards
In-Reply-To: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1454954357-8395-12-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add device tree files for AMD Overdrive boards which comes with
AMD Seattle Revision B0 and B1 SOCs.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/Makefile                 |  3 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts | 87 ++++++++++++++++++++++
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts | 91 ++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts

diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index cfdf701..db03293 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -1,4 +1,5 @@
-dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb
+dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb \
+			amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
new file mode 100644
index 0000000..8e3074a
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -0,0 +1,87 @@
+/*
+ * DTS file for AMD Seattle Overdrive Development Board
+ * Note: For Seattle Rev.B0
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ */
+
+/dts-v1/;
+
+/include/ "amd-seattle-soc.dtsi"
+
+/ {
+	model = "AMD Seattle (Rev.B0) Development Board (Overdrive)";
+	compatible = "amd,seattle-overdrive", "amd,seattle";
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	psci {
+		compatible   = "arm,psci-0.2";
+		method       = "smc";
+	};
+};
+
+&ccp0 {
+	status = "ok";
+	amd,zlib-support = <1>;
+};
+
+/**
+ * NOTE: In Rev.B, gpio0 is reserved.
+ */
+&gpio1 {
+	status = "ok";
+};
+
+&gpio2 {
+	status = "ok";
+};
+
+&gpio3 {
+	status = "ok";
+};
+
+&gpio4 {
+	status = "ok";
+};
+
+&i2c0 {
+	status = "ok";
+};
+
+&i2c1 {
+	status = "ok";
+};
+
+&pcie0 {
+	status = "ok";
+};
+
+&spi0 {
+	status = "ok";
+};
+
+&spi1 {
+	status = "ok";
+	sdcard0: sdcard at 0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		voltage-ranges = <3200 3400>;
+		pl022,hierarchy = <0>;
+		pl022,interface = <0>;
+		pl022,com-mode = <0x0>;
+		pl022,rx-level-trig = <0>;
+		pl022,tx-level-trig = <0>;
+	};
+};
+
+&ipmi_kcs {
+	status = "ok";
+};
+
+&smb0 {
+	/include/ "amd-seattle-xgbe-b.dtsi"
+};
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
new file mode 100644
index 0000000..ed5e043
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
@@ -0,0 +1,91 @@
+/*
+ * DTS file for AMD Seattle Overdrive Development Board
+ * Note: For Seattle Rev.B1
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ */
+
+/dts-v1/;
+
+/include/ "amd-seattle-soc.dtsi"
+
+/ {
+	model = "AMD Seattle (Rev.B1) Development Board (Overdrive)";
+	compatible = "amd,seattle-overdrive", "amd,seattle";
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	psci {
+		compatible   = "arm,psci-0.2";
+		method       = "smc";
+	};
+};
+
+&ccp0 {
+	status = "ok";
+	amd,zlib-support = <1>;
+};
+
+/**
+ * NOTE: In Rev.B, gpio0 is reserved.
+ */
+&gpio1 {
+	status = "ok";
+};
+
+&gpio2 {
+	status = "ok";
+};
+
+&gpio3 {
+	status = "ok";
+};
+
+&gpio4 {
+	status = "ok";
+};
+
+&i2c0 {
+	status = "ok";
+};
+
+&i2c1 {
+	status = "ok";
+};
+
+&pcie0 {
+	status = "ok";
+};
+
+&sata1 {
+	status = "ok";
+};
+
+&spi0 {
+	status = "ok";
+};
+
+&spi1 {
+	status = "ok";
+	sdcard0: sdcard at 0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		voltage-ranges = <3200 3400>;
+		pl022,hierarchy = <0>;
+		pl022,interface = <0>;
+		pl022,com-mode = <0x0>;
+		pl022,rx-level-trig = <0>;
+		pl022,tx-level-trig = <0>;
+	};
+};
+
+&ipmi_kcs {
+	status = "ok";
+};
+
+&smb0 {
+	/include/ "amd-seattle-xgbe-b.dtsi"
+};
-- 
2.5.0
