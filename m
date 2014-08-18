From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:25 +0800
Subject: [PATCH 6/6] ARM: dts: atlas6: Add I2S external clock input pingroup
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1408351765-18253-6-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

The I2S controller can use the external clock as reference clock with
master mode. But based on different hardware or software design, this
external clock might be needed or not needed.
So the external input pin can be an independent pinctrl group, and the
card driver can decice to get it or not.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index d3de7a3..1eb83c8 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -528,6 +528,12 @@
                                                 sirf,function = "i2s_mclk";
                                         };
                                 };
+				i2s_ext_clk_input_pins_a: i2s_ext_clk_input at 0 {
+                                        i2s_ext_clk_input {
+                                                sirf,pins = "i2s_ext_clk_inputgrp";
+                                                sirf,function = "i2s_ext_clk_input";
+                                        };
+                                };
                                 i2s_pins_a: i2s at 0 {
                                         i2s {
                                                 sirf,pins = "i2sgrp";
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
