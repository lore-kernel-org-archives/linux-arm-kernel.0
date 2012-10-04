From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  4 Oct 2012 14:57:22 +0300
Subject: [PATCH 3/9] ARM/dts: omap4-panda: Disable unused audio IPs
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1349351848-12972-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McBSP2, McBSP3 and DMIC is not usable on PandaBoard (not connected, no
external pins provided for them).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 20b966e..771cefd 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -137,3 +137,15 @@
 	cs1-used;
 	device-handle = <&elpida_ECB240ABACN>;
 };
+
+&mcbsp2 {
+	status = "disabled";
+};
+
+&mcbsp3 {
+	status = "disabled";
+};
+
+&dmic {
+	status = "disabled";
+};
-- 
1.7.12
