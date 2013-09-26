From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Sep 2013 12:22:48 -0300
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <21060.15934.600859.167074@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
Message-ID: <CAOMZO5AODznB9D+J2D1juoL=f5eBuJEyuNtN+DEYFuSdhNdt5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Thu, Sep 26, 2013 at 11:01 AM, =?utf-8?Q?Lothar_Wa=C3=9Fmann?=
<LW@karo-electronics.de> wrote:
> Does anyone have any clue how this can happen?
>
> Can anyone reproduce this on another machine?

Is the change below needed?

--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -310,7 +310,7 @@
                        };

                        can1: flexcan at 02090000 {
-                               compatible = "fsl,imx6q-flexcan";
+                               compatible = "fsl,imx6q-flexcan",
"fsl,p1010-flexcan";
                                reg = <0x02090000 0x4000>;
                                interrupts = <0 110 0x04>;
                                clocks = <&clks 108>, <&clks 109>;
@@ -318,7 +318,7 @@
                        };

                        can2: flexcan at 02094000 {
-                               compatible = "fsl,imx6q-flexcan";
+                               compatible = "fsl,imx6q-flexcan",
"fsl,p1010-flexcan";
                                reg = <0x02094000 0x4000>;
                                interrupts = <0 111 0x04>;
                                clocks = <&clks 110>, <&clks 111>;
