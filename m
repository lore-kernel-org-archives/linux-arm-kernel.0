From: hector.palacios@digi.com (Hector Palacios)
Date: Tue, 8 Apr 2014 18:55:05 +0200
Subject: ethaddr0 alias for imx6
Message-ID: <534429E9.1050202@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I think I'm missing a commit similar to 8c41d57395ff5b9b16724786c7c4b4c4081510cc to 
add the ethernet0 alias so that U-Boot can fixup the MAC in the device tree for iMX6. 
Like this:

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b48a128e519d..b3ec952eada6 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -15,6 +15,7 @@

  / {
         aliases {
+               ethernet0 = &fec;
                 flexcan0 = &flexcan1;
                 flexcan1 = &flexcan2;
                 gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index b937a4a94202..2afd45c67996 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -13,6 +13,7 @@

  / {
         aliases {
+               ethernet0 = &fec;
                 serial0 = &uart1;
                 serial1 = &uart2;
                 serial2 = &uart3;

Has this changed recently and is done in a different way or has nobody noticed it before?

Best regards,
--
Hector Palacios
