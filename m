From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:37 +0200
Subject: [PATCH 42/58] arm64: dts: renesas: r8a77965: m3nulcb-kf: Initial
 device tree
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <c41fc11850782c2e4115af683793bbb111c2d0ff.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eugeniu Rosca <roscaeugeniu@gmail.com>

This is based on the existing KF device tree sources:
$ ls -1 arch/arm64/boot/dts/renesas/*-kf.dts
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile                |  1 +
 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index eb158d1f90e9..a8ce6594342d 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb r8a77965-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-m3nulcb.dtb
+dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-m3nulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb r8a77980-v3hsk.dtb
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts b/arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts
new file mode 100644
index 000000000000..dadad97051b9
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the M3NULCB Kingfisher board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+
+#include "r8a77965-m3nulcb.dts"
+#include "ulcb-kf.dtsi"
+
+/ {
+	model = "Renesas M3NULCB Kingfisher board based on r8a77965";
+	compatible = "shimafuji,kingfisher", "renesas,m3nulcb",
+		     "renesas,r8a77965";
+};
-- 
2.11.0
