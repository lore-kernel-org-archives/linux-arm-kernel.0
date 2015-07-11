From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Jul 2015 02:29:19 +0200
Subject: [PATCH 1/4] ARM: dts: Add sbs-battery dts fragment used by chromebooks
In-Reply-To: <1436574562-16308-1-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
Message-ID: <1436574562-16308-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

This patch creates a sbs-battery fragment for batteries connected
to the i2c tunnel of the cros-ec embedded controller.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/cros-ec-sbs.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-ec-sbs.dtsi

diff --git a/arch/arm/boot/dts/cros-ec-sbs.dtsi b/arch/arm/boot/dts/cros-ec-sbs.dtsi
new file mode 100644
index 0000000..b76afe2
--- /dev/null
+++ b/arch/arm/boot/dts/cros-ec-sbs.dtsi
@@ -0,0 +1,18 @@
+/*
+ * Smart battery dts fragment for devices that use cros-ec-sbs
+ *
+ * Copyright (c) 2015 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+&i2c_tunnel {
+	battery: sbs-battery at b {
+		compatible = "sbs,sbs-battery";
+		reg = <0xb>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <1>;
+	};
+};
-- 
2.1.4
