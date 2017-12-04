From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Dec 2017 09:28:08 -0200
Subject: [PATCH 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded
 unit address
In-Reply-To: <20171204111954.v7jexbtkjyaa6mhe@t450s.lan>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-11-git-send-email-festevam@gmail.com>
 <20171204111954.v7jexbtkjyaa6mhe@t450s.lan>
Message-ID: <CAOMZO5C77f9mQQWJ5GJH3J+cj4Fxu3H-3yQYeFNDxm3xfpe8Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Mon, Dec 4, 2017 at 9:19 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> What about naming it i2c2mux and i2c3mux so it is clearer those mux
> happen respectively for i2c2 and i2c3?
>
> Then I'd rename the sub-nodes i2cXmux at Y instead of i2cX at Y currently.
>
> Let me know your thoughts.

Is this what you suggest?

--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -172,7 +172,7 @@
                };
        };

-       i2cmux at 2 {
+       i2c2mux {
                compatible = "i2c-mux-gpio";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_i2c2mux>;
@@ -183,20 +183,20 @@
                i2c-parent = <&i2c2>;
                idle-state = <0>;

-               i2c2 at 1 {
+               i2c2mux at 1 {
                        reg = <1>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                };

-               i2c2 at 2 {
+               i2c2mux at 2 {
                        reg = <2>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                };
        };

-       i2cmux at 3 {
+       i2c3mux {
                compatible = "i2c-mux-gpio";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_i2c3mux>;
@@ -206,7 +206,7 @@
                i2c-parent = <&i2c3>;
                idle-state = <0>;

-               i2c3 at 1 {
+               i2c3mux at 1 {
                        reg = <1>;
                        #address-cells = <1>;
                        #size-cells = <0>;
