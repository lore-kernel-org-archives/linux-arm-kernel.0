From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 14 Jul 2015 10:29:56 +0200
Subject: [PATCH v2 3/3] ARM: tegra: Add gpio-ranges property
In-Reply-To: <1436862596-27730-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1436862596-27730-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1436862596-27730-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify how the GPIOs map to the pins in Tegra SoCs, so the dependency is
explicit.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---

Changes in v2:
- Remove outdated comment from the commit changelog

 arch/arm/boot/dts/tegra114.dtsi | 1 +
 arch/arm/boot/dts/tegra124.dtsi | 1 +
 arch/arm/boot/dts/tegra20.dtsi  | 1 +
 arch/arm/boot/dts/tegra30.dtsi  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index f58a3d9d5f13..7e1e1717e46a 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -234,6 +234,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		gpio-ranges = <&pinmux 0 0 246>;
 	};
 
 	apbmisc at 70000800 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 87318a72f615..4779df336cb6 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -255,6 +255,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		gpio-ranges = <&pinmux 0 0 251>;
 	};
 
 	apbdma: dma at 0,60020000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index f444b67f55c6..b44277c63e8e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -244,6 +244,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		gpio-ranges = <&pinmux 0 0 224>;
 	};
 
 	apbmisc at 70000800 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 782b11b2af6a..28c547f27ecd 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -349,6 +349,7 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		gpio-ranges = <&pinmux 0 0 248>;
 	};
 
 	apbmisc at 70000800 {
-- 
2.4.3
