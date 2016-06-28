From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue, 28 Jun 2016 13:10:34 +0530
Subject: [PATCH v4 1/3] Documentation: DT: Add iproc-static-adc binding
In-Reply-To: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds devicetree binding document for broadcom's
iproc-static-adc controller driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
new file mode 100644
index 0000000..caaaed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
@@ -0,0 +1,41 @@
+* Broadcom's IPROC Static ADC controller
+
+Broadcom iProc ADC controller has 8 channels 10bit ADC.
+Allows user to convert analog input voltage values to digital.
+
+Required properties:
+
+- compatible: Must be "brcm,iproc-static-adc"
+
+- adc-syscon: Handler of syscon node defining physical base address of the
+  controller and length of memory mapped region.
+
+- #io-channel-cells = <1>; As ADC has multiple outputs
+  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+
+- io-channel-ranges:
+  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+
+- clocks: Clock used for this block.
+
+- clock-names: Clock name should be given as tsc_clk.
+
+- interrupts: interrupt line number.
+
+For example:
+
+	ts_adc_syscon: ts_adc_syscon at 180a6000 {
+		compatible = "brcm,iproc-ts-adc-syscon","syscon";
+		reg = <0x180a6000 0xc30>;
+	};
+
+	adc: adc at 180a6000 {
+		compatible = "brcm,iproc-static-adc";
+		adc-syscon = <&ts_adc_syscon>;
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+		clock-names = "tsc_clk";
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
-- 
1.9.1
