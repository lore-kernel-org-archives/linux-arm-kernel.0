From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:33 +0300
Subject: [PATCH v2 18/20] ARM: DTS: am335x-evm: Rename pinctrl section for
 McASP1
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-19-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use mcasp1_pins as name for the pinctrl section needed for McASP1 instead
of the am335x_evm_audio_pins name.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9cfb591a7f80..4db03859105a 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -342,7 +342,7 @@
 		>;
 	};
 
-	am335x_evm_audio_pins: am335x_evm_audio_pins {
+	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
 			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
 			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
@@ -576,7 +576,7 @@
 
 &mcasp1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&am335x_evm_audio_pins>;
+	pinctrl-0 = <&mcasp1_pins>;
 
 	status = "okay";
 
-- 
2.4.5
