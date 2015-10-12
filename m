From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Oct 2015 11:32:39 +0200
Subject: [PATCH v3 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <CAGb2v652CZAqU_S-p14g2sMQfOQYu_BBMnp0MdKR2Q5Y61UHog@mail.gmail.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66JnJwDLYQ40ckYp_OTrLmprYKPhXrV1ME66fEeF=Vewg@mail.gmail.com>
 <20151011172005.GV2278@lukather>
 <CAGb2v652CZAqU_S-p14g2sMQfOQYu_BBMnp0MdKR2Q5Y61UHog@mail.gmail.com>
Message-ID: <20151012093239.GA2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:20:37AM +0800, Chen-Yu Tsai wrote:
> >> > +};
> >> > +
> >> > +&reg_ldo2 {
> >> > +       regulator-min-microvolt = <2700000>;
> >> > +       regulator-max-microvolt = <3300000>;
> >> > +       regulator-name = "avcc";
> >> > +       regulator-always-on;
> >> > +};
> >> > +
> >> > +&reg_ldo5 {
> >> > +       regulator-min-microvolt = <1800000>;
> >> > +       regulator-max-microvolt = <1800000>;
> >> > +       regulator-name = "vcc-1v8";
> >> > +};
> >> > +
> >> > +&reg_usb0_vbus {
> >> > +       pinctrl-0 = <&chip_vbus_pin>;
> >> > +       vin-supply = <&reg_vcc5v0>;
> >> > +       gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
> >>
> >>           status = "okay"; ?
> >
> > Ah, yes, indeed.
> >
> >> The rest looks good.
> >
> > Is that an Ack from you if I add the status ?
> 
> Yes. Thanks!

Great :)

Applied with the extra status and your Ack.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/5b98cf2a/attachment-0001.sig>
