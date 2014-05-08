From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 8 May 2014 14:22:28 +0800
Subject: [PATCH] ARM: dts: sirf: add resets for dspif, gps and dsp nodes
Message-ID: <1399530149-28218-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tao Huang <Tao.Huang@csr.com>

this patch fills the resets properity for dspif, gps and dsp nodes.
these nodes belong to GPS related modules.

Signed-off-by: Tao Huang <Tao.Huang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 458e000..6684d55 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -172,6 +172,7 @@
 				compatible = "sirf,prima2-dspif";
 				reg = <0xa8000000 0x10000>;
 				interrupts = <9>;
+				resets = <&rstc 1>;
 			};
 
 			gps at a8010000 {
@@ -179,6 +180,7 @@
 				reg = <0xa8010000 0x10000>;
 				interrupts = <7>;
 				clocks = <&clks 9>;
+				resets = <&rstc 2>;
 			};
 
 			dsp at a9000000 {
@@ -186,6 +188,7 @@
 				reg = <0xa9000000 0x1000000>;
 				interrupts = <8>;
 				clocks = <&clks 8>;
+				resets = <&rstc 0>;
 			};
 		};
 
-- 
1.7.9.5



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
