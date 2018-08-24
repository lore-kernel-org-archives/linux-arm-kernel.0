From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 24 Aug 2018 11:16:28 -0500
Subject: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
In-Reply-To: <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
Message-ID: <CAL_Jsq+QrDR_YyZ+icftUrwOoMZcSCMkmj8cR=bqEJ-q+pdntg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 10:08 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:

[...]

> > > +               i2c at 3 {
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +                       reg = <0x3>;
> > > +
> > > +                       sa56004 at 4c {
> >
> > temperature-sensor at 4c
> Ok, temperature-sensor-1 at 4c

No, that's not what I said. You don't need the '-1' because the
unit-address makes the node name unique. Node names are supposed to be
generic based on the class/type of device. See the DT spec.

> >
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4c>;
> > > +                       };
> > > +
> > > +                       sa56004 at 4d {
> Ok,temperature-sensor-2 at 4d
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4d>;
> > > +                       };
> > > +               };
> > > +       };
> > > +};
> > > +
> > > +&i2c4 {
> > > +       status = "okay";
> > > +
> > > +       rtc at 51 {
> > > +               compatible = "nxp,pcf2129";
> > > +               reg = <0x51>;
> > > +               // IRQ10_B
> > > +               interrupts = <0 150 0x4>;
> > > +               };
> > > +
> > > +};
> > > +
> > > +&usb0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&usb1 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&crypto {
> > > +       status = "okay";
> > > +};
> > > --
> > > 2.7.4
> > >
