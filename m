From: robh@kernel.org (Rob Herring)
Date: Thu,  1 Mar 2018 14:25:36 -0600
Subject: [PATCH] arm: dts: stih4xx: Add missing #sound-dai-cells
Message-ID: <20180301202537.30571-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc now gives the following warnings:

arch/arm/boot/dts/stih410-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/stih407-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/stih410-b2260.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])

Add the missing #sound-dai-cells property.

Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/stih407.dtsi | 1 +
 arch/arm/boot/dts/stih410.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 11fdecd9312e..b592ecbe6420 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -107,6 +107,7 @@
 				compatible = "st,stih407-hdmi";
 				reg = <0x8d04000 0x1000>;
 				reg-names = "hdmi-reg";
+				#sound-dai-cells = <0>;
 				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
 				interrupt-names	= "irq";
 				clock-names = "pix",
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 68b5ff91d6a7..4bcdbbb70a31 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -198,6 +198,7 @@
 				compatible = "st,stih407-hdmi";
 				reg = <0x8d04000 0x1000>;
 				reg-names = "hdmi-reg";
+				#sound-dai-cells = <0>;
 				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
 				interrupt-names	= "irq";
 				clock-names = "pix",
-- 
2.14.1
