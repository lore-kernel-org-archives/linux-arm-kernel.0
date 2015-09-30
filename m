From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:55:17 +0100
Subject: [PATCH 3/8] nvmem: Add i.MX6 OCOTP device tree binding documentation
In-Reply-To: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443617717-26397-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This patch documents the i.MX6 OCOTP device tree binding.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/imx-ocotp.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
new file mode 100644
index 0000000..383d588
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -0,0 +1,20 @@
+Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
+
+This binding represents the on-chip eFuse OTP controller found on
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, and i.MX6SX SoCs.
+
+Required properties:
+- compatible: should be one of
+	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
+	"fsl,imx6sl-ocotp" (i.MX6SL), or
+	"fsl,imx6sx-ocotp" (i.MX6SX), followed by "syscon".
+- reg: Should contain the register base and length.
+- clocks: Should contain a phandle pointing to the gated peripheral clock.
+
+Example:
+
+	ocotp: ocotp at 021bc000 {
+		compatible = "fsl,imx6q-ocotp", "syscon";
+		reg = <0x021bc000 0x4000>;
+		clocks = <&clks IMX6QDL_CLK_IIM>;
+	};
-- 
1.9.1
