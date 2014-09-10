From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 09:33:36 +0800
Subject: [PATCH v1] ARM: dts: imx6dl: disable dma support for spi on i.mx6dl
Message-ID: <1410312816-32171-1-git-send-email-b38343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is one weird data in rxfifo after one full rx/tx transfer
done sometimes. It looks a design issue and hard to workaround
totally, so disable dma functhion here. And will re-enable it
once the root cause found.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index b453e0e..e84a1ff 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -102,6 +102,22 @@
 	};
 };
 
+&ecspi1 {
+	dma-names = "", "";
+};
+
+&ecspi2 {
+	dma-names = "", "";
+};
+
+&ecspi3 {
+	dma-names = "", "";
+};
+
+&ecspi4 {
+	dma-names = "", "";
+};
+
 &hdmi {
 	compatible = "fsl,imx6dl-hdmi";
 };
-- 
1.9.1
