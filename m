From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu,  3 Nov 2016 01:07:58 +1030
Subject: [PATCH v2 3/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LPCHC)
In-Reply-To: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
Message-ID: <1478097481-14895-4-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed LPC Host Controller is presented as a syscon device to
arbitrate access by LPC and pinmux drivers. LPC pinmux configuration on
fifth generation SoCs depends on bits in both the System Control Unit
and the LPC Host Controller.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
new file mode 100644
index 000000000000..792651488c3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpchc.txt
@@ -0,0 +1,17 @@
+* Device tree bindings for the Aspeed LPC Host Controller (LPCHC)
+
+The LPCHC registers configure LPC behaviour between the BMC and the host
+system. The LPCHC also participates in pinmux requests on g5 SoCs and is
+therefore considered a syscon device.
+
+Required properties:
+- compatible:		"aspeed,ast2500-lpchc", "syscon"
+- reg:			contains offset/length value of the LPCHC memory
+			region.
+
+Example:
+
+lpchc: lpchc at 1e7890a0 {
+	compatible = "aspeed,ast2500-lpchc", "syscon";
+	reg = <0x1e7890a0 0xc4>;
+};
-- 
2.7.4
