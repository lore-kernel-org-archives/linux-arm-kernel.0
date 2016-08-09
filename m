From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 9 Aug 2016 09:40:53 -0500
Subject: [PATCHv2 3/3] ARM: dts: Add Arria10 SD/MMC EDAC devicetree entry
In-Reply-To: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
References: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1470753653-23465-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera SD/MMC
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2  No change
---
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index 8a7dfa4..040a164 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -25,3 +25,15 @@
 	broken-cd;
 	bus-width = <4>;
 };
+
+&eccmgr {
+	sdmmca-ecc at ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+			     <47 IRQ_TYPE_LEVEL_HIGH>,
+			     <16 IRQ_TYPE_LEVEL_HIGH>,
+			     <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
1.7.9.5
