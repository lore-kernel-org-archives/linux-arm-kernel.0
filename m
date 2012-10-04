From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  4 Oct 2012 14:57:23 +0300
Subject: [PATCH 4/9] ARM/dts: omap4-sdp: Disable unused McBSP3
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1349351848-12972-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McBSP3 is not usable on OMAP4 SDP/Blaze (the pins used for McPDM).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 94a23b3..cf09875 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -349,3 +349,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
 };
+
+&mcbsp3 {
+	status = "disabled";
+};
-- 
1.7.12
