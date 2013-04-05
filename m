From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  5 Apr 2013 22:23:59 +0200
Subject: [PATCH v2 4/9] arm: dts: Add a 64 bits version of the skeleton device
 tree
In-Reply-To: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365193444-13441-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

In order to be able to use more than 4GB address-cells and size-cells
have to be set to 2

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/boot/dts/skeleton64.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 arch/arm/boot/dts/skeleton64.dtsi

diff --git a/arch/arm/boot/dts/skeleton64.dtsi b/arch/arm/boot/dts/skeleton64.dtsi
new file mode 100644
index 0000000..1599415
--- /dev/null
+++ b/arch/arm/boot/dts/skeleton64.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Skeleton device tree in the 64 bits version; the bare minimum
+ * needed to boot; just include and add a compatible value.  The
+ * bootloader will typically populate the memory node.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0>; };
+};
-- 
1.7.9.5
