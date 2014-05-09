From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri,  9 May 2014 18:53:01 +0530
Subject: [PATCH v9 1/4] ARM: dts: Add sysreg sytem controller node to
 exynos5250 and exynos5420
In-Reply-To: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
References: <1399641784-10833-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399641784-10833-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sysreg-syscon node to exynos5250 and exynos5420 device
tree, to access System Register's registers using syscon driver.

Signed-off-by: Kamil Debski <k.debski@samsung.com>
[gautam.vivek at samsung.com: Split this syreg-syscon dts entry from
dts: Add usb2phy to Exynos 5250 patch]
[gautam.vivek at samsung.com: added similar syscon entry for exynos5420]
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Changes since v7:
None

 arch/arm/boot/dts/exynos5250.dtsi |    5 +++++
 arch/arm/boot/dts/exynos5420.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..70f0cd5 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -175,6 +175,11 @@
 		reg = <0x10040000 0x5000>;
 	};
 
+	sysreg_system_controller: syscon at 10050000 {
+		compatible = "samsung,exynos5250-sys", "syscon";
+		reg = <0x10050000 0x5000>;
+	};
+
 	watchdog at 101D0000 {
 		compatible = "samsung,exynos5250-wdt";
 		reg = <0x101D0000 0x100>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index a802f74..5d5d6e3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -682,6 +682,11 @@
 		reg = <0x10040000 0x5000>;
 	};
 
+	sysreg_system_controller: syscon at 10050000 {
+		compatible = "samsung,exynos5420-sys", "syscon";
+		reg = <0x10050000 0x5000>;
+	};
+
 	tmu_cpu0: tmu at 10060000 {
 		compatible = "samsung,exynos5420-tmu";
 		reg = <0x10060000 0x100>;
-- 
1.7.10.4
