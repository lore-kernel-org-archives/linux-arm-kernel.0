From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:26 +0200
Subject: [PATCH v7 14/14] arm/tegra: add support for tegra30 based board cardhu
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1323875032-18221-15-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the tegra30 based cardhu development board. Cardhu is a tablet
formfactor reference design for tegra30. The patch provides a device tree for
the board, updates Makefile.boot to build the dtb, includes the platform in
Kconfig and updates board-dt.c.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts     |   36 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/Makefile.boot      |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
 3 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-cardhu.dts

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
new file mode 100644
index 0000000..70c41fc
--- /dev/null
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -0,0 +1,36 @@
+/dts-v1/;
+
+/include/ "tegra30.dtsi"
+
+/ {
+	model = "NVIDIA Tegra30 Cardhu evaluation board";
+	compatible = "nvidia,cardhu", "nvidia,tegra30";
+
+	memory {
+		reg = < 0x80000000 0x40000000 >;
+	};
+
+	serial at 70006000 {
+		clock-frequency = < 408000000 >;
+	};
+
+	i2c at 7000c000 {
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c400 {
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c500 {
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c700 {
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000d000 {
+		clock-frequency = <100000>;
+	};
+};
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index cf51a00..9a82094 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -7,3 +7,4 @@ dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
 dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
 dtb-$(CONFIG_MACH_TRIMSLICE) += tegra-trimslice.dtb
 dtb-$(CONFIG_MACH_VENTANA) += tegra-ventana.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra-cardhu.dtb
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index f44a29c..3c197e2 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -47,6 +47,7 @@ static void __init tegra30_dt_init(void)
 }
 
 static const char *tegra30_dt_board_compat[] = {
+	"nvidia,cardhu",
 	NULL
 };
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
