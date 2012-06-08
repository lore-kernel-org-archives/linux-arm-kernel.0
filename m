From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  8 Jun 2012 17:02:05 +0300
Subject: [PATCH 7/7] arm/dts: New dts file for PandaBoardES (4460)
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339164125-32534-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 4430 and 4460 version of PandaBoard mostly the same with
exception at least in audio setup.
Use the omap4-panda.dts file as a base and only override the differences
between the revisions.
For audio it is the name of the sound card and the routing information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-pandaES.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-pandaES.dts

diff --git a/arch/arm/boot/dts/omap4-pandaES.dts b/arch/arm/boot/dts/omap4-pandaES.dts
new file mode 100644
index 0000000..d4ba43a
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-pandaES.dts
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/include/ "omap4-panda.dts"
+
+/* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
+&sound {
+	ti,model = "PandaBoardES";
+
+	/* Audio routing */
+	ti,audio-routing =
+		"Headset Stereophone", "HSOL",
+		"Headset Stereophone", "HSOR",
+		"Ext Spk", "HFL",
+		"Ext Spk", "HFR",
+		"Line Out", "AUXL",
+		"Line Out", "AUXR",
+		"AFML", "Line In",
+		"AFMR", "Line In";
+};
-- 
1.7.8.6
