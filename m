From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 08:14:13 -0000
Subject: [v3 8/9] ARM: dt: tegra114: Add new board, Pluto
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358237598-32413-9-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new evaluation board, Pluto for Tegra 114 family.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/Makefile           |    3 ++-
 arch/arm/boot/dts/tegra114-pluto.dts |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/tegra114-pluto.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 04e43d2..32f47ce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -148,7 +148,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
 	tegra30-beaver.dtb \
-	tegra114-dalmore.dtb
+	tegra114-dalmore.dtb \
+	tegra114-pluto.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dts
new file mode 100644
index 0000000..9bea8f5
--- /dev/null
+++ b/arch/arm/boot/dts/tegra114-pluto.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+/include/ "tegra114.dtsi"
+
+/ {
+	model = "NVIDIA Tegra114 Pluto evaluation board";
+	compatible = "nvidia,pluto", "nvidia,tegra114";
+
+	memory {
+		reg = <0x80000000 0x40000000>;
+	};
+
+	serial at 70006300 {
+		status = "okay";
+		clock-frequency = <408000000>;
+	};
+
+	pmc {
+		nvidia,invert-interrupt;
+	};
+};
-- 
1.7.9.5
