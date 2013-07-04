From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:55:27 +0800
Subject: [PATCH 3/5] arm/dts: sirf: fix the pingroup name mismatch between
 drivers and dts
In-Reply-To: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
References: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1372924529-5519-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in drivers/pinctrl/sirf, pingroup name is cko0 and cko1, but in dts, they
are cko0 and cko1_rst. this patch fixes the error in dts.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/prima2.dtsi | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 6e24ecf..ab1183b 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -521,16 +521,16 @@
                                                 sirf,function = "pulse_count";
                                         };
                                 };
-                                cko0_rst_pins_a: cko0_rst at 0 {
-                                        cko0_rst {
-                                                sirf,pins = "cko0_rstgrp";
-                                                sirf,function = "cko0_rst";
+                                cko0_pins_a: cko0 at 0 {
+                                        cko0 {
+                                                sirf,pins = "cko0grp";
+                                                sirf,function = "cko0";
                                         };
                                 };
-                                cko1_rst_pins_a: cko1_rst at 0 {
-                                        cko1_rst {
-                                                sirf,pins = "cko1_rstgrp";
-                                                sirf,function = "cko1_rst";
+                                cko1_pins_a: cko1 at 0 {
+                                        cko1 {
+                                                sirf,pins = "cko1grp";
+                                                sirf,function = "cko1";
                                         };
                                 };
 			};
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 3329719..ce0266c 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -513,16 +513,16 @@
                                                 sirf,function = "pulse_count";
                                         };
                                 };
-                                cko0_rst_pins_a: cko0_rst at 0 {
-                                        cko0_rst {
-                                                sirf,pins = "cko0_rstgrp";
-                                                sirf,function = "cko0_rst";
+                                cko0_pins_a: cko0 at 0 {
+                                        cko0 {
+                                                sirf,pins = "cko0grp";
+                                                sirf,function = "cko0";
                                         };
                                 };
-                                cko1_rst_pins_a: cko1_rst at 0 {
-                                        cko1_rst {
-                                                sirf,pins = "cko1_rstgrp";
-                                                sirf,function = "cko1_rst";
+                                cko1_pins_a: cko1 at 0 {
+                                        cko1 {
+                                                sirf,pins = "cko1grp";
+                                                sirf,function = "cko1";
                                         };
                                 };
 			};
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
