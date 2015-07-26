From: tremyfr@gmail.com (Philippe Reynes)
Date: Sun, 26 Jul 2015 23:37:51 +0200
Subject: [PATCH v5 4/6] dt-binding: document the binding for mxc rtc
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1437946673-7402-5-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
mxc rtc.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   26 +++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
new file mode 100644
index 0000000..49aa550
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
@@ -0,0 +1,26 @@
+* Real Time Clock of the i.MX SoCs
+
+RTC controller for the i.MX SoCs
+
+Required properties:
+- compatible: Should be "fsl,imx1-rtc" or "fsl,imx21-rtc".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the RTC.
+- clocks: should contain two entries:
+  * one for the input reference
+  * one for the the SoC RTC
+- clock-names: should contain:
+  * "ref" for the input reference clock
+  * "ipg" for the SoC RTC clock
+
+Example:
+
+rtc at 10007000 {
+	compatible = "fsl,imx21-rtc";
+	reg = <0x10007000 0x1000>;
+	interrupts = <22>;
+	clocks = <&clks IMX27_CLK_CKIL>,
+	       	 <&clks IMX27_CLK_RTC_IPG_GATE>;
+	clock-names = "ref", "ipg";
+};
-- 
1.7.4.4
