From: huayi.li@csr.com (Huayi Li)
Date: Wed, 16 Jul 2014 10:01:53 +0800
Subject: [PATCH v5 2/4] pwm: sirf: add dt-binding document
Message-ID: <1405476113-10127-1-git-send-email-huayi.li@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding document for pwm-sirf. here the controller clock
can't generate PWM signals, so we need seperate clock as signal source.

Signed-off-by: Huayi Li <huayi.li@csr.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sirf.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
new file mode 100644
index 0000000..221e5d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
@@ -0,0 +1,29 @@
+SiRF prima2 & atlas6 PWM drivers
+
+Required properties:
+- compatible: "sirf,prima2-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clock/prima2-clock.txt for details.
+- clock-names: Must include the following entries:
+  of clock sources to generate PWM signal,
+  - pwmc: PWM controller clock
+  - sigsrc0: source clock 0 for PWM
+  - sigsrc1: source clock 1 for PWM
+  - sigsrc2: source clock 2 for PWM
+  - sigsrc3: source clock 3 for PWM
+  - sigsrc4: source clock 4 for PWM
+
+Example:
+
+pwm: pwm at b0130000 {
+	compatible = "sirf,prima2-pwm";
+	#pwm-cells = <2>;
+	reg = <0xb0130000 0x10000>;
+	clocks = <&clks 21>, <&clks 1>, <&clks 2>,
+	       <&clks 3>, <&clks 0>, <&clks 4>;
+	clock-names = "pwmc", "sigsrc0", "sigsrc1",
+		"sigsrc2", "sigsrc3", "sigsrc4";
+};
-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
