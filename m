From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 10:47:53 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: rename prima2-cb.dts to prima2.dtsi as it
 only has SoC features
In-Reply-To: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345690074-31327-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

The current prima2-cb.dts only includes prima2 SoC feature without board-
specific descriptions. This patches rename it to dtsi and clean some useless
content.

Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 arch/arm/boot/dts/{prima2-cb.dts => prima2.dtsi} |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)
 rename arch/arm/boot/dts/{prima2-cb.dts => prima2.dtsi} (96%)

diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2.dtsi
similarity index 96%
rename from arch/arm/boot/dts/prima2-cb.dts
rename to arch/arm/boot/dts/prima2.dtsi
index 4245306..1b716aa 100644
--- a/arch/arm/boot/dts/prima2-cb.dts
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -1,20 +1,18 @@
-/dts-v1/;
+/*
+ * DTS file for CSR SiRFprimaII SoC
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
 / {
-	model = "SiRF Prima2 eVB";
-	compatible = "sirf,prima2-cb", "sirf,prima2";
+	compatible = "sirf,prima2";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
-	memory {
-		reg = <0x00000000 0x20000000>;
-	};
-
-	chosen {
-		bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS0 panel=1 bootsplash=true bpp=16 androidboot.console=ttyS1";
-		linux,stdout-path = &uart1;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
