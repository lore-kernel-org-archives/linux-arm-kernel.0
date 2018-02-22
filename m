From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 12:39:46 +0100
Subject: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
In-Reply-To: <20180221171504.dac7yikrqfnjiiog@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
 <20180221171504.dac7yikrqfnjiiog@verge.net.au>
Message-ID: <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 6:15 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 20, 2018 at 04:46:23PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> > Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>> >
>> > Based on original work from:
>> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> > Magnus Damm <damm+renesas@opensource.se>
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, applied with prefix updated to
>
> "arm64: dts: renesas:"
>
> There was some fuzz applying this patch, the result is as follows.
>
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Subject: [PATCH] arm64: dts: renesas: Add R-Car Salvator-x M3-N support
>
> Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>
> Based on original work from:
> Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Magnus Damm <damm+renesas@opensource.se>
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Something went wrong with this patch, I suspect it's missing some prerequisites
that fill in a few more device nodes to avoid these warnings in linux-next:

arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/ethernet at e6800000/ethernet-phy at 0
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e6510000/codec at 10 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e6510000/clk_multiplier at 4f
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e66d8000/gpio at 20 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e66d8000/adc at 7c has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e66d8000/adc at 7f has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e66d8000/clock-generator at 6a
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c at e60b0000/pmic at 30 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display at feb00000/ports/port at 0 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display at feb00000/ports/port at 1 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display at feb00000/ports/port at 2 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/ethernet at e6800000/ethernet-phy at 0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/ethernet at e6800000/ethernet-phy at 0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e6510000/codec at 10
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e6510000/codec at 10
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e6510000/clk_multiplier at 4f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e6510000/clk_multiplier at 4f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e66d8000/gpio at 20
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e66d8000/gpio at 20
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e66d8000/adc at 7c
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e66d8000/adc at 7c
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e66d8000/adc at 7f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e66d8000/adc at 7f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e66d8000/clock-generator at 6a
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e66d8000/clock-generator at 6a
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c at e60b0000/pmic at 30
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c at e60b0000/pmic at 30
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display at feb00000/ports/port at 0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display at feb00000/ports/port at 0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display at feb00000/ports/port at 1
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display at feb00000/ports/port at 1
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display at feb00000/ports/port at 2
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display at feb00000/ports/port at 2
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(phys_property): Missing property '#phy-cells' in node
/soc/usb-phy at e65ee000 or bad phandle (referred from
/soc/usb at ee020000:phys[0])
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(pwms_property): Missing property '#pwm-cells' in node
/soc/pwm at e6e31000 or bad phandle (referred from /backlight:pwms[0])
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(interrupts_property): Missing interrupt-controller or interrupt-map
property in /soc/interrupt-controller at e61c0000
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(interrupts_property): Missing #interrupt-cells in interrupt-parent
/soc/interrupt-controller at e61c0000

Maybe just take out the patch adding the .dts file for the time being until
the important nodes are all in place?

        Arnd
