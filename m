From: m.weisser.m@gmail.com (=?UTF-8?Q?Matthias_Wei=C3=9Fer?=)
Date: Thu, 4 Jul 2013 17:03:21 +0200
Subject: imx25: How to get frame buffer device in a system using device tree
Message-ID: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I am currently try to get Linux running on a custom imx25 hardware
using device tree. So far I am quite successfull and have the system
up using current mainline kernel and a NFS root file system. Now I
would like to have the framebuffer driver to get something on the LCD.

My dts file looks like this:

/dts-v1/;
#include "imx25.dtsi"

/ {
  model = "Graf-Syteco zmx25";
  compatible = "graf,imx25-zmx25", "fsl,imx25";

  memory {
    reg = <0x80000000 0x4000000>;
  };

  soc {
    aips at 53f00000 { /* AIPS2 */
      lcdc at 53fbc000 {
        status = "okay";
      };
    };
  };
};

&uart1 {
  status = "okay";
};

&uart2 {
  status = "okay";
};

&fec {
  phy-mode = "rmii";
  status = "okay";
};

I also added the compatibility entry in the imx25.dtsi

--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -378,6 +378,7 @@
                        };

                        lcdc at 53fbc000 {
+                               compatible = "fsl,imx27-fb", "fsl,imx21-fb";
                                reg = <0x53fbc000 0x4000>;
                                interrupts = <39>;
                                clocks = <&clks 103>, <&clks 66>, <&clks 49>;

But still I didn't get /dev/fb so I think I am doing something wrong.
Any hints for docs I can study on how to do the right things?

Regards
Matthias
