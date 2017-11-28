From: Jan.Tuerk@emtrion.de (=?iso-8859-1?Q?T=FCrk=2C_Jan?=)
Date: Tue, 28 Nov 2017 11:52:50 +0100
Subject: AW: [PATCH 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <20171126192410.4eoujidx4nv3b2jf@rob-hp-laptop>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171123125600.41562-5-jan.tuerk@emtrion.com>
 <20171126192410.4eoujidx4nv3b2jf@rob-hp-laptop>
Message-ID: <95F51F4B902CAC40AF459205F6322F01B7F903E18F@BMK019S01.emtrion.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

thanks for your feedback, the changes will be included in V2 of the patch-series.

Jan
> Von: Rob Herring
> Gesendet: Sonntag, 26. November 2017 20:24
> On Thu, Nov 23, 2017 at 01:55:54PM +0100, Jan Tuerk wrote:
> > This patch adds support for the emtrion GmbH emCON-MX6 modules.
> > They are available with imx.6 Solo, Dual-Lite, Dual and Quad
> > equipped with Memory from 512MB to 2GB (configured by U-Boot).
 [...]
> > +&i2c3 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c3>;
> > +       status = "okay";
> > +
> > +       sgtl5000: sgtl5000 at 0a {
>
> audio-codec at a
>
> same errors repeat below.
changed for v2
>
> > +               compatible = "fsl,sgtl5000";
> > +               reg = <0x0a>;
> > +               clocks = <&sndosc>;
> > +               VDDA-supply = <&base3p3>;
> > +               VDDIO-supply = <&base3p3>;
> > +       };
> > +
> > +       boardID: pca8754a at 3A {
>
> ... at 3a
changed in V2
>
> > +               compatible = "nxp,pca8574";
> > +               reg = <0x3A>;
>
> 0x3a
>
> > +               gpio-controller;
> > +               #gpio-cells = <1>;
> > +       };
> > +
> > +       captouch: edt-ft5x06 at 38 {
>
> touchscreen at 38

>
> > +               reg = <0x38>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_irq_touch2 &pinctrl_emcon_gpio4>;
> > +               interrupt-parent = <&gpio6>;
> > +               interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> > +               compatible = "edt,edt-ft5406";
> > +               wake-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> > +               wakeup-source;
> > +       };
> > +};
> > +
> > +&ssi2 {
> > +       status = "okay";
> > +};
> > +
> > +&rgb_encoder {
> > +       status = "okay";
> > +};
> > +
[...]
> > +
> > +       rgb_panel: panel {
> > +               backlight = <&rgb_backlight>;
> > +               power-supply = <&reg_prallel_disp>;
> > +               port {
> > +                       rgb_panel_in: endpoint {
> > +                               remote-endpoint = <&rgb_encoder_out>;
> > +                       };
> > +               };
> > +       };
> > +
> > +       rgb_backlight: rgb_backlight {
>
> rgb-backlight {
[...]
> > +
> > +       lvds_backlight: lvds_backlight {
>
> lvds-backlight {

Ok, I'll change that in V2

[...]
> > +
> > +&i2c1 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c1>;
> > +       status = "okay";
> > +
> > +       rtc: rtc at 68 {
> > +               compatible = "dallas,ds1307";
> > +               reg = <0x68>;
> > +       };
> > +
> > +       da9063: da9063 at 58 {
>
> pmic at 38
changed
>
> > +               compatible = "dlg,da9063";
> > +               reg = <0x58>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_pmic>;
> > +               interrupt-parent = <&gpio2>;
> > +
[....]
> > +
> > +       mdio {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               ksz9031: phy {
>
> phy at 0
>
> Building with W=2 or W=1 will tell you this.
thanks for the hint, it will be also included in v2
>
> > +                       reg = <0>;
> > +                       compatible = "ethernet-phy-ieee802.3-c22";
> > +                       interrupt-parent = <&gpio1>;
> > +                       interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> > +                       rxdv-skew-ps = <480>;
> > +                       txen-skew-ps = <480>;
[...]

emtrion GmbH
Kreativpark - Alter Schlachthof 45
76131 Karlsruhe
GERMANY
http://www.emtrion.de
_______________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_______________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winmail.dat
Type: application/ms-tnef
Size: 6207 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/189d82e1/attachment.bin>
