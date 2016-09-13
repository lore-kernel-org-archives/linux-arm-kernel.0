From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 13 Sep 2016 21:51:17 +0200
Subject: [PATCH 3/3] ARM: dts: lpc18xx: add boot rom node
In-Reply-To: <20160913195117.2887-1-manabian@gmail.com>
References: <20160913195117.2887-1-manabian@gmail.com>
Message-ID: <20160913195117.2887-4-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the boot ROM found on all NXP LPC18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 631e6f6c..9f94f3e 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -81,6 +81,14 @@
 			status = "disabled";
 		};
 
+		boot_rom: firmware at 10400000 {
+			compatible = "nxp,lpc1850-boot-rom";
+			reg = <0x10400000 0x10000>;
+			syscon = <&creg>;
+			nvmem-cells = <&part_id>;
+			nvmem-cell-names = "PartID";
+		};
+
 		dmac: dma-controller at 40002000 {
 			compatible = "arm,pl080", "arm,primecell";
 			arm,primecell-periphid = <0x00041080>;
-- 
2.9.3
