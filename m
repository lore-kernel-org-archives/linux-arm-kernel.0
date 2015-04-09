From: harald@ccbib.org (harald at ccbib.org)
Date: Thu, 09 Apr 2015 15:03:40 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Add i2c support
In-Reply-To: <5526444A.3060805@i2se.com>
References: <1428515100-1496-1-git-send-email-harald@ccbib.org>
 <1158701263.68321.1428531175931.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <3f0efa88b69ea2e8eb22909b6fbe6f91@imap.cosmopool.net>
 <5526444A.3060805@i2se.com>
Message-ID: <d8d27c22eb78aed693a977b88ebcc327@imap.cosmopool.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan!

On Thu, 09 Apr 2015 11:20:10 +0200, Stefan Wahren <stefan.wahren@i2se.com>
wrote:
> Hi Harald,
> 
>>>> This patch provides the necessary devicetree code.
>>>> Tested with MOD-LCD1x9 from Olimex.
>>>>
>>>> This patch is based on work by Fadil Berisha with his permission.
>> However
>>>> all bugs are mine.
>>>>
>>>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>>>> ---
>>>> arch/arm/boot/dts/imx23-olinuxino.dts | 6 +++++
>>>> arch/arm/boot/dts/imx23.dtsi | 40 ++++++++++++++++++++++++++++++++-
>>>> 2 files changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> [...]
>>>> --- a/arch/arm/boot/dts/imx23.dtsi
>>>> +++ b/arch/arm/boot/dts/imx23.dtsi
>>>> @@ -308,6 +308,39 @@
>>>> fsl,voltage = <MXS_VOLTAGE_HIGH>;
>>>> fsl,pull-up = <MXS_PULL_ENABLE>;
>>>> };
>>>> +
>>>> + i2c_pins_a: i2c at 0 {
>>>> + reg = <0>;
>>>> + fsl,pinmux-ids = <
>>>> + MX23_PAD_I2C_SCL__I2C_SCL
>>>> + MX23_PAD_I2C_SDA__I2C_SDA
>>>> + >;
>>>> + fsl,drive-strength = <MXS_DRIVE_8mA>;
>>>> + fsl,voltage = <MXS_VOLTAGE_HIGH>;
>>>> + fsl,pull-up = <MXS_PULL_ENABLE>;
>>>> + };
>>>> +
>>>> + i2c_pins_b: i2c at 1 {
>>>> + reg = <1>;
>>>> + fsl,pinmux-ids = <
>>>> + MX23_PAD_LCD_ENABLE__I2C_SCL
>>>> + MX23_PAD_LCD_HSYNC__I2C_SDA
>>>> + >;
>>>> + fsl,drive-strength = <MXS_DRIVE_8mA>;
>>>> + fsl,voltage = <MXS_VOLTAGE_HIGH>;
>>>> + fsl,pull-up = <MXS_PULL_ENABLE>;
>>>> + };
>>>> +
>>>> + i2c_pins_c: i2c at 2 {
>>>> + reg = <2>;
>>>> + fsl,pinmux-ids = <
>>>> + MX23_PAD_SSP1_DATA1__I2C_SCL
>>>> + MX23_PAD_SSP1_DATA2__I2C_SDA
>>>> + >;
>>>> + fsl,drive-strength = <MXS_DRIVE_8mA>;
>>>> + fsl,voltage = <MXS_VOLTAGE_HIGH>;
>>>> + fsl,pull-up = <MXS_PULL_ENABLE>;
>>>> + };
>>> Please add only i2c_pins_b because this pin muxing is the only used
one.
>> I disagree: Having all possible i2c pin groups documented in devicetree
>> is
>> a good thing. Also imx23.dtsi is more general then olinuxino - somebody
>> might produce a imx23 based board where one of the other pin groups
makes
>> more sense to use. Well, even on olinuxino somebody might use
i2c_pins_a
>> if they don't need an UART, but use an LCD.
> 
> Sure. But this 2 additional muxes have nothing to do with adding i2c
> support to olinuxino and should be a separate patch. In case of a revert
> of this patch the other i.MX23 boards are also affected. So i think it
> should be a separate patch.

If it is prefered, I will split the changes to imx23.dtsi and
imx23-olinuxino.dts into two patches.

> Btw i read that Shawn only want used muxes [1].
> 
> [1] -
>
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115779.html

If that is an issue, then I'll just test all three pin groups on my
olinuxino
board. After all it would be really awkward to have only one pin group and
that
one is labeled "i2c_pins_b" ...

Thanks,
Harald
