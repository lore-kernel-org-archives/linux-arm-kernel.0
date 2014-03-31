From: tthayer@altera.com (tthayer at altera.com)
Date: Mon, 31 Mar 2014 17:07:06 -0500
Subject: [PATCH 1/2] dts: socfpga: Add bindings for Altera SoC SDRAM controller
In-Reply-To: <1396303627-29198-1-git-send-email-tthayer@altera.com>
References: <1396303627-29198-1-git-send-email-tthayer@altera.com>
Message-ID: <1396303627-29198-2-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Addition of the Altera SDRAM controller bindings and device
tree changes to the Altera SoC project.

Signed-off-by: Thor Thayer <tthayer@altera.com>
To: Rob Herring <rob.herring@calxeda.com>
To: Pawel Moll <pawel.moll@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
To: Ian Campbell <ijc+devicetree@hellion.org.uk>
To: Kumar Gala <galak@codeaurora.org>
To: Rob Landley <rob@landley.net>
To: Russell King <linux@arm.linux.org.uk>
To: Dinh Nguyen <dinguyen@altera.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 .../bindings/arm/altera/socfpga-sdram.txt          |   14 ++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
new file mode 100644
index 0000000..351ab7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
@@ -0,0 +1,14 @@
+Altera SOCFPGA SDRAM Controller
+
+Required properties:
+- compatible : "altr,sdr-ctl", "syscon";
+                Note that syscon is invoked for this device to support the FPGA
+		bridge driver and possibly other devices in the future.  See
+		also Documentation/devicetree/bindings/mfd/syscon.txt
+- reg : Should contain 1 register ranges(address and length)
+
+Example:
+	sdrctl at 0xffc25000 {
+		compatible = "altr,sdr-ctl", "syscon";
+		reg = <0xffc25000 0x1000>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9e78c1d..3634de7 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -528,6 +528,11 @@
 			reg-io-width = <4>;
 		};
 
+		sdrctl at 0xffc25000 {
+			compatible = "altr,sdr-ctl", "syscon";
+			reg = <0xffc25000 0x1000>;
+		};
+
 		rstmgr at ffd05000 {
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
-- 
1.7.9.5
