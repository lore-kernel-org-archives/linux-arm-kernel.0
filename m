From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:48 +0200
Subject: [PATCH 3/9] ARM: dts: sk-rzg1e: add SCIF2 pins
In-Reply-To: <cover.1502962873.git.horms+renesas@verge.net.au>
References: <cover.1502962873.git.horms+renesas@verge.net.au>
Message-ID: <8774ee66ae478fab7d57bd9f6cd5a27981a4be92.1502962873.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) SCIF2 pin data to the SK-RZG1E board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
index 97840b340197..0cd908796055 100644
--- a/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
+++ b/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the SK-RZG1E board
  *
- * Copyright (C) 2016 Cogent Embedded, Inc.
+ * Copyright (C) 2016-2017 Cogent Embedded, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -34,7 +34,17 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif2_pins: scif2 {
+		groups = "scif2_data";
+		function = "scif2";
+	};
+};
+
 &scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
-- 
2.1.4
