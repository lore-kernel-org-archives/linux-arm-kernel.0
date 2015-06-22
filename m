From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 22 Jun 2015 14:32:32 +0800
Subject: [PATCH v4 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <1434944170.25921.6.camel@mtksdaap41>
References: <1434553683-11651-1-git-send-email-eddie.huang@mediatek.com>
 <1434553683-11651-3-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omCVFwHndKSN0A7PrYUArfPLfCoL6iiSJYEik1PVkMBrKA@mail.gmail.com>
 <1434944170.25921.6.camel@mtksdaap41>
Message-ID: <CAGS+omAW=L3S2TG3Vw8=7UrkmcDMMQDmpKikmC+BO5iMUVr2CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 11:36 AM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> Hi Dan,
>
> On Thu, 2015-06-18 at 23:16 +0800, Daniel Kurtz wrote:
>> On Wed, Jun 17, 2015 at 11:08 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
>> > Add MT8173 I2C device nodes, include I2C controllers and pins.
>> > MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
>> > The 6th I2C controller register base doesn't next to 5th I2C,
>> > and there is a hardware between 5th and 6th I2C controller. So
>> > SoC designer name 6th controller as "i2c6", not "i2c5".
>> >
>> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> > ---
>> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 144 +++++++++++++++++++++++++++++++
>> >  1 file changed, 144 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > index b52ec43..1816c8f 100644
>> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> > @@ -158,6 +158,54 @@
>> >                         interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> >                                                 <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> >                                                 <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>> > +
>> > +                       i2c0_pins_a: i2c0 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_45_SDA0__FUNC_SDA0>,
>> > +                                                <MT8173_PIN_46_SCL0__FUNC_SCL0>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> > +
>> > +                       i2c1_pins_a: i2c1 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_125_SDA1__FUNC_SDA1>,
>> > +                                                <MT8173_PIN_126_SCL1__FUNC_SCL1>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> > +
>> > +                       i2c2_pins_a: i2c2 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_43_SDA2__FUNC_SDA2>,
>> > +                                                <MT8173_PIN_44_SCL2__FUNC_SCL2>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> > +
>> > +                       i2c3_pins_a: i2c3 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_106_SDA3__FUNC_SDA3>,
>> > +                                                <MT8173_PIN_107_SCL3__FUNC_SCL3>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> > +
>> > +                       i2c4_pins_a: i2c4 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_133_SDA4__FUNC_SDA4>,
>> > +                                                <MT8173_PIN_134_SCL4__FUNC_SCL4>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> > +
>> > +                       i2c6_pins_a: i2c6 {
>> > +                               pins1 {
>> > +                                       pinmux = <MT8173_PIN_100_MSDC2_DAT0__FUNC_SDA5>,
>> > +                                                <MT8173_PIN_101_MSDC2_DAT1__FUNC_SCL5>;
>> > +                                       bias-disable;
>> > +                               };
>> > +                       };
>> >                 };
>> >
>> >                 watchdog: watchdog at 10007000 {
>> > @@ -229,6 +277,102 @@
>> >                         clocks = <&uart_clk>;
>> >                         status = "disabled";
>> >                 };
>> > +
>> > +               i2c0: i2c at 11007000 {
>> > +                       compatible = "mediatek,mt8173-i2c";
>> > +                       reg = <0 0x11007000 0 0x70>,
>> > +                             <0 0x11000100 0 0x80>;
>> > +                       interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
>> > +                       clock-div = <16>;
>>
>> According to the i2c-mt6577 dt binding:
>>    - clock-div: the fixed value for frequency divider of clock source in i2c
>>      module. Each IC may be different.
>>
>> For other drivers I've seen this kind of hardware-specific value
>> implemented as a table in the driver that is indexed based on the
>> compatible.
>>
>> Any particular reason to specify it here in every device tree node instead?
>>
>
> If put in device tree, it is not necessary to add new compatible if new
> SoC has the same I2C controller hardware except clock-div.The benefit is
> keep driver clean, but the side-effect is add clock-div in device node.I
> assume clock-div has the same concept of clock, so I put in device tree.

Sounds reasonable to me.  This patch is:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> Eddie
> Thanks
>
>
