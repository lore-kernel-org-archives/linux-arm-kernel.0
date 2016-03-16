From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Mar 2016 09:39:10 -0500
Subject: [PATCH] ARM: dts: k2*: Rename the k2* files to keystone-k2* files
Message-ID: <1458139150-30382-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported in [1], rename the k2* dts files to keystone-* files
this will force consistency throughout.

Script for the same (and hand modified for Makefile and MAINTAINERS
files):
for i in arch/arm/boot/dts/k2*
do
	b=`basename $i`;
	git mv $i arch/arm/boot/dts/keystone-$b;
	sed -i -e "s/$b/keystone-$b/g" arch/arm/boot/dts/*[si]
done

NOTE: bootloaders that depend on older dtb names will need to be
updated as well.

[1] http://marc.info/?l=linux-arm-kernel&m=145637407804754&w=2

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on next-20160316
Ignored:
 - all the build warnings reported in http://www.spinics.net/lists/arm-kernel/msg490058.html
 - k2g* files which for some reason appears in linux-next, but not part of pull request:
 	http://marc.info/?l=linux-arm-kernel&m=145643709430175&w=2

 MAINTAINERS                                                       | 2 +-
 arch/arm/boot/dts/Makefile                                        | 6 +++---
 arch/arm/boot/dts/{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi}   | 0
 arch/arm/boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts}           | 2 +-
 arch/arm/boot/dts/{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi}     | 0
 arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi}                 | 4 ++--
 arch/arm/boot/dts/{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi} | 0
 arch/arm/boot/dts/{k2hk-evm.dts => keystone-k2hk-evm.dts}         | 2 +-
 arch/arm/boot/dts/{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi}   | 0
 arch/arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi}               | 4 ++--
 arch/arm/boot/dts/{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi}   | 0
 arch/arm/boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts}           | 2 +-
 arch/arm/boot/dts/{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi}     | 0
 arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi}                 | 4 ++--
 14 files changed, 13 insertions(+), 13 deletions(-)
 rename arch/arm/boot/dts/{k2e-clocks.dtsi => keystone-k2e-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e-evm.dts => keystone-k2e-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2e-netcp.dtsi => keystone-k2e-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2e.dtsi => keystone-k2e.dtsi} (97%)
 rename arch/arm/boot/dts/{k2hk-clocks.dtsi => keystone-k2hk-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk-evm.dts => keystone-k2hk-evm.dts} (99%)
 rename arch/arm/boot/dts/{k2hk-netcp.dtsi => keystone-k2hk-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2hk.dtsi => keystone-k2hk.dtsi} (96%)
 rename arch/arm/boot/dts/{k2l-clocks.dtsi => keystone-k2l-clocks.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l-evm.dts => keystone-k2l-evm.dts} (98%)
 rename arch/arm/boot/dts/{k2l-netcp.dtsi => keystone-k2l-netcp.dtsi} (100%)
 rename arch/arm/boot/dts/{k2l.dtsi => keystone-k2l.dtsi} (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c0be602d57c..a00233edbe83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,7 +1260,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-keystone/
-F:	arch/arm/boot/dts/k2*
+F:	arch/arm/boot/dts/keystone-*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 
 ARM/TEXAS INSTRUMENT KEYSTONE CLOCK FRAMEWORK
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0d6bf2875cc7..f06b4b849db2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -158,9 +158,9 @@ dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 	integratorap.dtb \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_KEYSTONE) += \
-	k2hk-evm.dtb \
-	k2l-evm.dtb \
-	k2e-evm.dtb \
+	keystone-k2hk-evm.dtb \
+	keystone-k2l-evm.dtb \
+	keystone-k2e-evm.dtb \
 	keystone-k2g-evm.dtb
 dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-b3.dtb \
diff --git a/arch/arm/boot/dts/k2e-clocks.dtsi b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2e-clocks.dtsi
rename to arch/arm/boot/dts/keystone-k2e-clocks.dtsi
diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
similarity index 98%
rename from arch/arm/boot/dts/k2e-evm.dts
rename to arch/arm/boot/dts/keystone-k2e-evm.dts
index b7e99807f5c2..4c32ebc1425a 100644
--- a/arch/arm/boot/dts/k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -10,7 +10,7 @@
 /dts-v1/;
 
 #include "keystone.dtsi"
-#include "k2e.dtsi"
+#include "keystone-k2e.dtsi"
 
 / {
 	compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone";
diff --git a/arch/arm/boot/dts/k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2e-netcp.dtsi
rename to arch/arm/boot/dts/keystone-k2e-netcp.dtsi
diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
similarity index 97%
rename from arch/arm/boot/dts/k2e.dtsi
rename to arch/arm/boot/dts/keystone-k2e.dtsi
index 1097dada56d2..96b349fb0430 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -44,7 +44,7 @@
 	};
 
 	soc {
-		/include/ "k2e-clocks.dtsi"
+		/include/ "keystone-k2e-clocks.dtsi"
 
 		usb: usb at 2680000 {
 			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
@@ -145,6 +145,6 @@
 			clock-names = "fck";
 			bus_freq	= <2500000>;
 		};
-		/include/ "k2e-netcp.dtsi"
+		/include/ "keystone-k2e-netcp.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2hk-clocks.dtsi
rename to arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
similarity index 99%
rename from arch/arm/boot/dts/k2hk-evm.dts
rename to arch/arm/boot/dts/keystone-k2hk-evm.dts
index 8161bf53271b..b38b3441818b 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -10,7 +10,7 @@
 /dts-v1/;
 
 #include "keystone.dtsi"
-#include "k2hk.dtsi"
+#include "keystone-k2hk.dtsi"
 
 / {
 	compatible =  "ti,k2hk-evm", "ti,k2hk", "ti,keystone";
diff --git a/arch/arm/boot/dts/k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2hk-netcp.dtsi
rename to arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
similarity index 96%
rename from arch/arm/boot/dts/k2hk.dtsi
rename to arch/arm/boot/dts/keystone-k2hk.dtsi
index ada4c7ac96e7..8f67fa8df936 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -44,7 +44,7 @@
 	};
 
 	soc {
-		/include/ "k2hk-clocks.dtsi"
+		/include/ "keystone-k2hk-clocks.dtsi"
 
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
@@ -112,6 +112,6 @@
 			clock-names = "fck";
 			bus_freq	= <2500000>;
 		};
-		/include/ "k2hk-netcp.dtsi"
+		/include/ "keystone-k2hk-netcp.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/k2l-clocks.dtsi b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2l-clocks.dtsi
rename to arch/arm/boot/dts/keystone-k2l-clocks.dtsi
diff --git a/arch/arm/boot/dts/k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
similarity index 98%
rename from arch/arm/boot/dts/k2l-evm.dts
rename to arch/arm/boot/dts/keystone-k2l-evm.dts
index 00861244d788..7f9c2e94d605 100644
--- a/arch/arm/boot/dts/k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -10,7 +10,7 @@
 /dts-v1/;
 
 #include "keystone.dtsi"
-#include "k2l.dtsi"
+#include "keystone-k2l.dtsi"
 
 / {
 	compatible = "ti,k2l-evm", "ti,k2l", "ti,keystone";
diff --git a/arch/arm/boot/dts/k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
similarity index 100%
rename from arch/arm/boot/dts/k2l-netcp.dtsi
rename to arch/arm/boot/dts/keystone-k2l-netcp.dtsi
diff --git a/arch/arm/boot/dts/k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
similarity index 96%
rename from arch/arm/boot/dts/k2l.dtsi
rename to arch/arm/boot/dts/keystone-k2l.dtsi
index 4446da72b0ae..ff22ffc3dee7 100644
--- a/arch/arm/boot/dts/k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -32,7 +32,7 @@
 	};
 
 	soc {
-		/include/ "k2l-clocks.dtsi"
+		/include/ "keystone-k2l-clocks.dtsi"
 
 		uart2: serial at 02348400 {
 			compatible = "ns16550a";
@@ -92,7 +92,7 @@
 			clock-names = "fck";
 			bus_freq	= <2500000>;
 		};
-		/include/ "k2l-netcp.dtsi"
+		/include/ "keystone-k2l-netcp.dtsi"
 	};
 };
 
-- 
2.7.0
