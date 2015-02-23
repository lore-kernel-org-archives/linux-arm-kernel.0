From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Feb 2015 18:40:15 +0100
Subject: [PATCH v9 5/5] ARM: dts: imx6qdl: Allow disabling the PU regulator,
 add a enable ramp delay
In-Reply-To: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
References: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1424713215-3357-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PU regulator is enabled during boot, but not necessarily always-on.
It can be disabled by the generic pm domain framework when the PU power
domain is shut down. The ramp delay of 150 us might be a bit conservative,
the value is taken from the Freescale kernel.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v8:
 - Removed regulator-boot-on, this depends on the bootloader
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7ab00a4..4b12ac0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -598,7 +598,7 @@
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
 					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
+					regulator-enable-ramp-delay = <150>;
 					anatop-reg-offset = <0x140>;
 					anatop-vol-bit-shift = <9>;
 					anatop-vol-bit-width = <5>;
-- 
2.1.4
