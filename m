From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 3 May 2016 09:13:58 -0500
Subject: [PATCH] ARM: dts: socfpga: add ethernet alias on Arria10
Message-ID: <1462284838-14852-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Without having an ethernet alias, ethernet will have a random MAC address,
versus take an address that was provided from the bootloader.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 567df98..ab33ee3 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -20,6 +20,10 @@
 	model = "Altera SOCFPGA Arria 10";
 	compatible = "altr,socfpga-arria10", "altr,socfpga";
 
+	aliases {
+		ethernet0 = &gmac0;
+	};
+
 	chosen {
 		bootargs = "earlyprintk";
 		stdout-path = "serial1:115200n8";
-- 
2.6.2
