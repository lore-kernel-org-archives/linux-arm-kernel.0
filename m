From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:12:01 -0600
Subject: [PATCH 13/13] dtb: amd: Add support for AMD/Linaro 96Boards
 Enterprise Edition Server board
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-14-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add device tree file for AMD/Linaro 96Boards Enterprise Edition Server
(Husky) Board. This is based on the AMD Seattle Rev.B0 system

Signed-off-by: Leo Duran <leo.duran@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/Makefile  |  3 +-
 arch/arm64/boot/dts/amd/husky.dts | 83 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/amd/husky.dts

diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index db03293..ba84770 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb \
-			amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
+			amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb \
+			husky.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amd/husky.dts b/arch/arm64/boot/dts/amd/husky.dts
new file mode 100644
index 0000000..1381d4b
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/husky.dts
@@ -0,0 +1,83 @@
+/*
+ * DTS file for AMD/Linaro 96Boards Enterprise Edition Server (Husky) Board
+ * Note: Based-on AMD Seattle Rev.B0
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ */
+
+/dts-v1/;
+
+/include/ "amd-seattle-soc.dtsi"
+
+/ {
+	model = "Linaro 96Boards Enterprise Edition Server (Husky) Board";
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
+&smb0 {
+	/include/ "amd-seattle-xgbe-b.dtsi"
+};
-- 
2.5.0
