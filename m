From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 15 Aug 2014 15:19:10 +0530
Subject: [PATCH 1/6] Documentation: DT: Add bindings for FSL NS16550A UART
In-Reply-To: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1408096156-29772-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch addss the device-tree documentation for Freescale's
NS16550 UART (also called DUART).

There is a specific errata fix required in FSL NS16550 UART
which ensures that an random interrupt storm is not observed when
a break is provided as an input to the UART.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/serial/fsl-ns16550.txt     |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-ns16550.txt

diff --git a/Documentation/devicetree/bindings/serial/fsl-ns16550.txt b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
new file mode 100644
index 0000000..9926e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
@@ -0,0 +1,24 @@
+* Freescale DUART is very similar to the PC16552D (and to a
+  pair of NS16550A), albeit with some nonstandard behavior such as
+  erratum A-004737 (relating to incorrect BRK handling).
+
+- compatible: "fsl,ns16550"
+
+  Represents a single port that is compatible with the DUART found
+  on many Freescale chips (examples include mpc8349, mpc8548,
+  mpc8641d, p4080 and ls2085a).
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clock-frequency = Input clock to the baud rate divider.
+
+Example:
+	serial1: serial at 21c4600 {
+		compatible = "fsl,ns16550", "ns16550a";
+		reg = <0x0 0x21c4600 0x0 0x100>;
+		clock-frequency = <0>;
+		interrupts = <0 32 0x1>;
+	};
+
-- 
1.7.9.5
