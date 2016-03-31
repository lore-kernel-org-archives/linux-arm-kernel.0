From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 31 Mar 2016 13:48:07 -0500
Subject: [PATCHv2 7/7] ARM: dts: Add Altera Arria10 OCRAM EDAC devicetree entry
In-Reply-To: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
References: <1459450087-24792-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1459450087-24792-8-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera On-Chip
RAM EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: No change
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 519e9e4..27cc497 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -612,6 +612,11 @@
 				compatible = "altr,socfpga-a10-l2-ecc";
 				reg = <0xffd06010 0x4>;
 			};
+
+			ocram-ecc at ff8c3000 {
+				compatible = "altr,socfpga-a10-ocram-ecc";
+				reg = <0xff8c3000 0x400>;
+			};
 		};
 
 		rst: rstmgr at ffd05000 {
-- 
1.7.9.5
