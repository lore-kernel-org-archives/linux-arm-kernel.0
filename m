From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 07 Dec 2016 14:00:41 +0530
Subject: [PATCH] ARM: EXYNOS: remove smp hook from machine descriptor
Message-ID: <1481099441-27657-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CPU_METHOD_OF_DECLARE() for smp_ops instead of using it
via machine descriptor.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi      | 1 +
 arch/arm/boot/dts/exynos4210.dtsi      | 1 +
 arch/arm/boot/dts/exynos4212.dtsi      | 1 +
 arch/arm/boot/dts/exynos4412.dtsi      | 1 +
 arch/arm/boot/dts/exynos5250.dtsi      | 1 +
 arch/arm/boot/dts/exynos5260.dtsi      | 1 +
 arch/arm/boot/dts/exynos5410.dtsi      | 1 +
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 1 +
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 1 +
 arch/arm/boot/dts/exynos5440.dtsi      | 1 +
 arch/arm/mach-exynos/common.h          | 2 --
 arch/arm/mach-exynos/exynos.c          | 1 -
 arch/arm/mach-exynos/platsmp.c         | 2 ++
 13 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ba17ee1..f28f669 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -53,6 +53,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7f3a18c..6dfd98d 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -35,6 +35,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 900 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5389011..3e8982e 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -25,6 +25,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at A00 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 40beede..faf2fb8 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -25,6 +25,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at A00 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6d7444..580897c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -52,6 +52,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 5818718..1af6e76 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -32,6 +32,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2b6adaf..b092cdc 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -33,6 +33,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 5c052d7..a587704 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -24,6 +24,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index bf3c6f1..7fcdfd0 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -23,6 +23,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu0: cpu at 100 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 2a2e570..0a958e8 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -50,6 +50,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "samsung,exynos-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index fb12d11..051e1ab 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -143,8 +143,6 @@ static inline void exynos_pm_init(void) {}
 extern void exynos_cpu_resume(void);
 extern void exynos_cpu_resume_ns(void);
 
-extern const struct smp_operations exynos_smp_ops;
-
 extern void exynos_cpu_power_down(int cpu);
 extern void exynos_cpu_power_up(int cpu);
 extern int  exynos_cpu_power_state(int cpu);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fa08ef9..f0a766e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -211,7 +211,6 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.l2c_aux_val	= 0x3c400001,
 	.l2c_aux_mask	= 0xc20fffff,
-	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
 	.init_irq	= exynos_init_irq,
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 94405c7..43eec10 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -474,3 +474,5 @@ const struct smp_operations exynos_smp_ops __initconst = {
 	.cpu_die		= exynos_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(exynos_smp, "samsung,exynos-smp", &exynos_smp_ops);
-- 
2.7.4
