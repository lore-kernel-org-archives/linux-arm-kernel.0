From: andreas@kemnade.info (Andreas Kemnade)
Date: Fri, 28 Apr 2017 12:27:35 +0200
Subject: [PATCH] dt: gta04: fix polarity of clocks for mcbsp4
Message-ID: <1493375255-21094-1-git-send-email-andreas@kemnade.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock polarity setting of the mcbsp connected to
the modem was wrong so almost only noise
was received.
With this patch it is also the same as it was on
earlier non-dt kernels where it was working properly

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 16b237d3..c0d9d4b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -68,7 +68,8 @@
 		simple-audio-card,bitclock-master = <&telephony_link_master>;
 		simple-audio-card,frame-master = <&telephony_link_master>;
 		simple-audio-card,format = "i2s";
-
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-inversion;
 		simple-audio-card,cpu {
 			sound-dai = <&mcbsp4>;
 		};
-- 
2.1.4
