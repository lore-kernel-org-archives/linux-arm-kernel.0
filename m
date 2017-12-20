From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 20 Dec 2017 23:11:45 +0000
Subject: [PATCH 1/4] ARM: dts: vf610-zii-dev: enable edma1
In-Reply-To: <20171220231108.GJ10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
Message-ID: <E1eRnWb-0006V7-9T@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EDMA1 is required for the SPI controller used on the ZII boards to be
functional.  Enable EDMA1.

Fixes: 14c416336820 ("ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 6b58d3a97992..aadd36db0092 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -96,6 +96,10 @@
 	status = "okay";
 };
 
+&edma1 {
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-- 
2.7.4
