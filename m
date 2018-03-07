From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 15:39:27 +0100
Subject: [GIT PULL 5/6] omap dts changes for v4.17
In-Reply-To: <pull-1520273005-304551@atomide.com-5>
References: <pull-1520273005-304551@atomide.com>
 <pull-1520273005-304551@atomide.com-5>
Message-ID: <CAK8P3a39+eDD_6iwuOam4dmr2FjyJ0D-8inJ+cZiw9uW6PvYFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> This series of changes updates the device tree files for omaps:
>
> - Nokia N9 support for magnetometer
>
> - Update at24 to use atmel as manufacturer for am335x-boneblue
>
> - Add support for am33xx based PDU001 board
>
> - Update Droid 4 touchscreen for reset-gpios and add audio
>   codec and soundcard
>
> - Remove unused dra7 cooling level nodes
>
> - A series of changes to configure am335x and am437x for PM
>
> - Add pinmuxing for i2c2 and 3 for LogicPD boards
>
> - Add EMIF interrupt infor for am437x and am335x
>
> - Add missing omap3 sound-dai-cells

Pulled into next/dt with a simple conflict resolution as shown
below, thanks!

      Arnd

diff --cc arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 47915447a826,d2135c2f4a37..3e174e474d3d
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@@ -138,12 -140,18 +142,24 @@@
                        OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT |
MUX_MODE0)        /* hsusb0_data7.hsusb0_data7 */
                >;
        };
 +      i2c1_pins: pinmux_i2c1_pins {
 +              pinctrl-single,pins = <
 +                      OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT |
MUX_MODE0)        /* i2c1_scl.i2c1_scl */
 +                      OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT |
MUX_MODE0)        /* i2c1_sda.i2c1_sda */
 +              >;
 +      };
+       i2c2_pins: pinmux_i2c2_pins {
+               pinctrl-single,pins = <
+                       OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT |
MUX_MODE0)        /* i2c2_scl */
+                       OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT |
MUX_MODE0)        /* i2c2_sda */
+               >;
+       };
+       i2c3_pins: pinmux_i2c3_pins {
+               pinctrl-single,pins = <
+                       OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT |
MUX_MODE0)        /* i2c3_scl */
+                       OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT |
MUX_MODE0)        /* i2c3_sda */
+               >;
+       };
  };

  &uart2 {
