From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 May 2013 14:46:58 +0400
Subject: [PATCH 2/3] ARM: dts: Add SPI support for i.MX27 Phytec PCM038 module
In-Reply-To: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
Message-ID: <1367405219-19078-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added SPI node to imx27-phytec-phycore DT file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index fe64e3a..b0e9372 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -72,6 +72,12 @@
 	};
 };
 
+&cspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 28 0>;
+	status = "okay";
+};
+
 &nfc {
 	nand-bus-width = <8>;
 	nand-ecc-mode = "hw";
-- 
1.8.1.5
