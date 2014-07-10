From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 10 Jul 2014 12:56:36 +0530
Subject: [PATCH V9 5/7] ARM: SPEAr13xx: Add bindings and dt node for misc block
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Message-ID: <23080439ce6c96dbbe9f73e085fc4391c28cf785.1404976059.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr SOCs have some miscellaneous registers which are used to configure
peripheral.

This patch adds dt node and binding information for this block.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: devicetree at vger.kernel.org
[viresh: fixed logs/cclist]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/arm/spear-misc.txt | 9 +++++++++
 arch/arm/boot/dts/spear13xx.dtsi                     | 5 +++++
 arch/arm/mach-spear/Kconfig                          | 1 +
 3 files changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/spear-misc.txt

diff --git a/Documentation/devicetree/bindings/arm/spear-misc.txt b/Documentation/devicetree/bindings/arm/spear-misc.txt
new file mode 100644
index 0000000..cf64982
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear-misc.txt
@@ -0,0 +1,9 @@
+SPEAr Misc configuration
+===========================
+SPEAr SOCs have some miscellaneous registers which are used to configure
+few properties of different peripheral controllers.
+
+misc node required properties:
+
+- compatible Should be	"st,spear1340-misc", "syscon".
+- reg: Address range of misc space upto 8K
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 4382547..3a72508 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -220,6 +220,11 @@
 				  0xd8000000 0xd8000000 0x01000000
 				  0xe0000000 0xe0000000 0x10000000>;
 
+			misc: syscon at e0700000 {
+				compatible = "st,spear1340-misc", "syscon";
+				reg = <0xe0700000 0x1000>;
+			};
+
 			gpio0: gpio at e0600000 {
 				compatible = "arm,pl061", "arm,primecell";
 				reg = <0xe0600000 0x1000>;
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 90df202..ba57677 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -19,6 +19,7 @@ config ARCH_SPEAR13XX
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select MFD_SYSCON
 	help
 	  Supports for ARM's SPEAR13XX family
 
-- 
2.0.0.rc2
