From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Oct 2015 10:20:37 +0800
Subject: [PATCH v3 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <20151011172005.GV2278@lukather>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66JnJwDLYQ40ckYp_OTrLmprYKPhXrV1ME66fEeF=Vewg@mail.gmail.com>
 <20151011172005.GV2278@lukather>
Message-ID: <CAGb2v652CZAqU_S-p14g2sMQfOQYu_BBMnp0MdKR2Q5Y61UHog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 1:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Oct 09, 2015 at 11:22:23PM +0800, Chen-Yu Tsai wrote:
>> On Fri, Oct 9, 2015 at 4:42 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The C.H.I.P. is a small SBC with an Allwinner R8, 8GB of NAND, 512MB of
>> > RAM, USB host and OTG, a wifi / bluetooth combo chip, an audio/video jack
>> > and two connectors to plug additional boards on top of it.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> > ---
>> >  arch/arm/boot/dts/Makefile          |   3 +-
>> >  arch/arm/boot/dts/sun5i-r8-chip.dts | 213 ++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 215 insertions(+), 1 deletion(-)
>> >  create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index 342ab3116feb..bf165ed4e7fa 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -600,7 +600,8 @@ dtb-$(CONFIG_MACH_SUN5I) += \
>> >         sun5i-a13-olinuxino.dtb \
>> >         sun5i-a13-olinuxino-micro.dtb \
>> >         sun5i-a13-q8-tablet.dtb \
>> > -       sun5i-a13-utoo-p66.dtb
>> > +       sun5i-a13-utoo-p66.dtb \
>> > +       sun5i-r8-chip.dtb
>> >  dtb-$(CONFIG_MACH_SUN6I) += \
>> >         sun6i-a31-app4-evb1.dtb \
>> >         sun6i-a31-colombus.dtb \
>> > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
>> > new file mode 100644
>> > index 000000000000..0d450a828372
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
>>
>> snip
>>
>> > +&reg_dcdc2 {
>> > +       regulator-min-microvolt = <1000000>;
>> > +       regulator-max-microvolt = <1400000>;
>> > +       regulator-name = "cpuvdd";
>>
>> Other boards seem to follow the power pin names on the SoC and call
>> this "vdd-cpu".
>>
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_dcdc3 {
>> > +       regulator-min-microvolt = <1000000>;
>> > +       regulator-max-microvolt = <1300000>;
>> > +       regulator-name = "corevdd";
>>
>> And this was named "vdd-int" or "vdd-int-dll" (for SoCs with separate
>> VDD_DLL pins).
>>
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_ldo1 {
>> > +       regulator-name = "rtcvdd";
>>
>> And this one was "vdd-rtc".
>>
>> I know you followed the names set in the design doc. Just wondering if there
>> should be some convention on these.
>
> I think if we have a document that clearly reference them with some
> other name, we should just stick with the name used there, especially
> if it's only cosmetic, which is the case here.

That's a good rule to follow. :)

>> > +};
>> > +
>> > +&reg_ldo2 {
>> > +       regulator-min-microvolt = <2700000>;
>> > +       regulator-max-microvolt = <3300000>;
>> > +       regulator-name = "avcc";
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_ldo5 {
>> > +       regulator-min-microvolt = <1800000>;
>> > +       regulator-max-microvolt = <1800000>;
>> > +       regulator-name = "vcc-1v8";
>> > +};
>> > +
>> > +&reg_usb0_vbus {
>> > +       pinctrl-0 = <&chip_vbus_pin>;
>> > +       vin-supply = <&reg_vcc5v0>;
>> > +       gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
>>
>>           status = "okay"; ?
>
> Ah, yes, indeed.
>
>> The rest looks good.
>
> Is that an Ack from you if I add the status ?

Yes. Thanks!

ChenYu
