From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 11 Nov 2015 07:46:05 +0100
Subject: [PATCH] ARM: dts: imx6dl: Fix gpt compatibles, remove imx6q-gpt
Message-ID: <1447224365-1210-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6qdl.dtsi uses compatibles "fsl,imx6q-gpt", "fsl,imx31-gpt".
imx6dl.dtsi uses compatibles "fsl,imx6dl-gpt", "fsl,imx6q-gpt" since
commit

	4e415ed8143f (ARM: dts: imx6dl: add imx6dl gpt specific compatible string)

If imx6dl would be compatible with imx6q-gpt it would also have to be
compatible with imx31-gpt which is currently missing.

Based on the above mentioned patch I assume imx6q-gpt and imx6dl-gpt are
not compatible. So imx6q-gpt should be removed as compatible.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b0ec0703825..e44ee075bdcc 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -107,7 +107,7 @@
 };
 
 &gpt {
-	compatible = "fsl,imx6dl-gpt", "fsl,imx6q-gpt";
+	compatible = "fsl,imx6dl-gpt";
 };
 
 &hdmi {
-- 
2.6.1
