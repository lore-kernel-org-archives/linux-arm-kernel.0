From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  9 Apr 2013 00:41:29 +0200
Subject: [PATCH v2 3/3] ARM: Kirkwood: update Network Space Mini v2 description
In-Reply-To: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
References: <1365460889-22965-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1365460889-22965-4-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LaCie has released two products under the CloudBox name. The
netspace_mini_v2 machine is embedded in the oldest product. The cloudbox
machine is embedded in the newest one. In order to allow a CloudBox user
to select the right machine support, this patch adds some informations
to the netspace_mini_v2 Kconfig description. A comment is also added to
the dts file.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/kirkwood-ns2mini.dts |    1 +
 arch/arm/mach-kirkwood/Kconfig         |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index b79f5eb..adab1ab 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -3,6 +3,7 @@
 /include/ "kirkwood-ns2-common.dtsi"
 
 / {
+	/* This machine is embedded in the first LaCie CloudBox product. */
 	model = "LaCie Network Space Mini v2";
 	compatible = "lacie,netspace_mini_v2", "marvell,kirkwood-88f6192", "marvell,kirkwood";
 
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 45ab2f5..7509a89 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -258,8 +258,12 @@ config MACH_NETSPACE_MINI_V2_DT
 	select ARCH_KIRKWOOD_DT
 	help
 	  Say 'Y' here if you want your kernel to support the LaCie
-	  Network Space Mini v2 NAS (aka SafeBox), using Flattened
-	  Device Tree.
+	  Network Space Mini v2 NAS using Flattened Device Tree.
+
+	  This board is embedded in a product named CloudBox, which
+	  provides automatic backup on a 100GB cloud storage. This
+	  should not confused with a more recent LaCie NAS also named
+	  CloudBox. For this last, the disk capacity is 1TB or above.
 
 config MACH_NETSPACE_V2_DT
 	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
-- 
1.7.10.4
