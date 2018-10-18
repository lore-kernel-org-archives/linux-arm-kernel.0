From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 02:32:49 +0000
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <20181018005130.GA8173@bogus>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
 <AM0PR04MB4211ECC04FD48918E9DFBAB880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181018005130.GA8173@bogus>
Message-ID: <AM0PR04MB4211160A6355E226E6033B2380F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > > > +               imx8qx-pm {
> > > > +                       compatible = "fsl,scu-pd";
> > > > +                       #address-cells = <1>;
> > > > +                       #size-cells = <0>;
> > > > +
> > > > +                       pd_lsio: lsio-power-domain {
> > > > +                               #power-domain-cells = <0>;
> > > > +                               #address-cells = <1>;
> > > > +                               #size-cells = <0>;
> > > > +
> > > > +                               pd_lsio_pwm0: lsio-pwm0 at 191 {
> > > > +                                       reg = <191>;
> > >
> > > The number after @ is in hex, so the reg property should be 0x191.
> >
> > Thanks for the reminder.
> > The PD ID is defined in DEC. So I will change them all into HEX later manually.
> >
> > BTW, this seems like error prone and checkpatch can't report it.
> 
> checkpatch doesn't really check dts files.
> 
> But if it did would you have noticed? Because there is at least one checkpatch
> issue with your author name and S-o-b name not matching.
> 
> > And I notice many similar users in kernel with the same issue:
> > arch/arm/boot/dts/tps65910.dtsi
> > arch/arm/boot/dts/tegra124-nyan.dtsi
> > arch/arm/boot/dts/rk3288.dtsi
> 
> At least I2C and SPI are now checked by dtc. 'simple-bus' children were too,
> but silently broke and only recently got fixed in upstream dtc.
> I've not pulled that into the kernel yet, but you can build dtbs using an external
> copy of dtc. And guess what, there are *lots* of warnings.
> 

Thanks for the info. Will try it.

Regards
Dong Aisheng

> Rob
