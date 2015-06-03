From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jun 2015 15:46:06 +0800
Subject: [PATCH] ARM: dts: imx6dl: add imx6dl gpt sepcific compatible string
Message-ID: <1433317566-4338-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The i.MX6DL/S GPT has a different programming model from i.MX6Q one.
Add the compatible string "fsl,imx6dl-gpt" for it, and leave
"fsl,imx6q-gpt" there to keep the existing/old kernel happy.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6dl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index f94bf72832af..4b0ec0703825 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -106,6 +106,10 @@
 	};
 };
 
+&gpt {
+	compatible = "fsl,imx6dl-gpt", "fsl,imx6q-gpt";
+};
+
 &hdmi {
 	compatible = "fsl,imx6dl-hdmi";
 };
-- 
1.9.1
