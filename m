From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Sep 2014 15:05:15 +0200
Subject: [PATCH v8 5/5] ARM: dts: imx6qdl: Allow disabling the PU regulator,
 add a enable ramp delay
In-Reply-To: <1410267915-18126-1-git-send-email-p.zabel@pengutronix.de>
References: <1410267915-18126-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1410267915-18126-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PU regulator is enabled during boot, but not necessarily always-on.
It can be disabled by the generic pm domain framework when the PU power
domain is shut down. The ramp delay of 150 us might be a bit conservative,
the value is taken from the Freescale kernel.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 0b1384c..d8d3d93 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -579,7 +579,8 @@
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
 					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
+					regulator-enable-ramp-delay = <150>;
+					regulator-boot-on;
 					anatop-reg-offset = <0x140>;
 					anatop-vol-bit-shift = <9>;
 					anatop-vol-bit-width = <5>;
-- 
2.1.0
