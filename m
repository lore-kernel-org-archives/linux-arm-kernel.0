From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:23 -0000
Subject: [PATCH 2/3] ARM: dts: sun5i: add spi2 on A10s Olinuxino Micro
In-Reply-To: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
References: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
Message-ID: <602069f7735ad37b1849dac484d2e8e7c9ec08b3.1464129859.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi2 is available on the UEXT connector

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 86d046a..7d2ff60 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -192,6 +192,13 @@
 	status = "okay";
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>,
+		    <&spi2_cs0_pins_a>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.8.1
