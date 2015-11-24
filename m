From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 11:16:04 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: alt: Correct scif2 pfc
In-Reply-To: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
References: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448331365-21388-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

22b160713cb6 ("ARM: shmobile: alt: Add pfc pins to DT") introduced pfc pins
to the alt device tree but did not reference them. This patch fixes scif2
pfc by adding references to the scif2 pins.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Corrected commit referenced in changelog
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
