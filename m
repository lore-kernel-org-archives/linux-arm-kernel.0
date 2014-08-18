From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:23 +0800
Subject: [PATCH 4/6] ARM: dts: atlas6: add a separate pingroup for i2s mclk
 output
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1408351765-18253-4-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

The I2S controller can output mclk to external audio codec. But by
hardware design, some codecs need mclk and some codecs do not need
mclk. So the mclk pin can be an independent pinctrl group, and the
card driver can get it or not based on boards.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index bb22842..d3de7a3 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -522,6 +522,12 @@
                                                 sirf,function = "sdmmc5";
                                         };
                                 };
+				i2s_mclk_pins_a: i2s_mclk at 0 {
+                                        i2s_mclk {
+                                                sirf,pins = "i2smclkgrp";
+                                                sirf,function = "i2s_mclk";
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
