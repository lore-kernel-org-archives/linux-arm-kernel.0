From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 26 Aug 2014 12:38:23 +0800
Subject: [PATCH 11/12] arm: mmp: Make all the dts file to be compiled by
 Makefile
In-Reply-To: <1409027904-21859-1-git-send-email-chao.xie@marvell.com>
References: <1409027904-21859-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1409027904-21859-12-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Add items in arch/arm/boot/dt/Makefile to compile the dtb
for mach-mmp.
Change the dts and dtsi file to use #include instead of \include\

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/boot/dts/Makefile            | 3 +++
 arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
 arch/arm/boot/dts/mmp2.dtsi           | 2 +-
 arch/arm/boot/dts/pxa168-aspenite.dts | 2 +-
 arch/arm/boot/dts/pxa168.dtsi         | 2 +-
 arch/arm/boot/dts/pxa910-dkb.dts      | 2 +-
 arch/arm/boot/dts/pxa910.dtsi         | 2 +-
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index acb6b42..16f91c9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -159,6 +159,9 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_ARCH_MMP) += pxa168-aspenite.dtb \
+	pxa910-dkb.dtb \
+	mmp2-brownstone.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 7f70a39..350208c 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "mmp2.dtsi"
+#include "mmp2.dtsi"
 
 / {
 	model = "Marvell MMP2 Brownstone Development Board";
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4e8b08c..e44f996 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -7,7 +7,7 @@
  *  publishhed by the Free Software Foundation.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index e762fac..0a988b3 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "pxa168.dtsi"
+#include "pxa168.dtsi"
 
 / {
 	model = "Marvell PXA168 Aspenite Development Board";
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 975dad2..bfcbdef 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -7,7 +7,7 @@
  *  publishhed by the Free Software Foundation.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index 595492a..c82f281 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "pxa910.dtsi"
+#include "pxa910.dtsi"
 
 / {
 	model = "Marvell PXA910 DKB Development Board";
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 0247c62..884c6e8 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -7,7 +7,7 @@
  *  publishhed by the Free Software Foundation.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	aliases {
-- 
1.8.3.2
