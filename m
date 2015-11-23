From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Nov 2015 16:16:43 +0900
Subject: [PATCH 1/2] ARM: shmobile: alt: Correct scif2 pfc
In-Reply-To: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
References: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448263004-14548-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
pfc pins to the alt device tree but did not reference them. This patch
fixes scif2 pfc by adding references to the scif2 pins.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index fd1cfcdd65ef..412eb7ad86db 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -182,5 +182,8 @@
 };
 
 &scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.1.4
