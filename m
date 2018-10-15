From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 15 Oct 2018 09:29:37 +0000
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <52eaa4ac563ad5114ebd99b286cdbe0495dba7ec.camel@nxp.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
 <52eaa4ac563ad5114ebd99b286cdbe0495dba7ec.camel@nxp.com>
Message-ID: <AM0PR04MB421145E95CE4F229A21999D180FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Leonard Crestez
> Sent: Monday, October 15, 2018 3:30 PM

> On Sun, 2018-10-14 at 20:13 -0300, Fabio Estevam wrote:
> > > +               imx8qx-pm {
> > > +                       compatible = "fsl,scu-pd";
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +
> > > +                       pd_lsio: lsio-power-domain {
> > > +                               #power-domain-cells = <0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +
> > > +                               pd_lsio_pwm0: lsio-pwm0 at 191 {
> > > +                                       reg = <191>;
> >
> > The number after @ is in hex, so the reg property should be 0x191.
> 
> These are SC_R_* resource ids from include/linux/firmware/imx/types.h
> and they are almost everywhere referenced as decimals.
> 
> Is this really not acceptable for DT?
> 

I think the problem is mismatch as DT binding request the reg property value
must be equal to the unit-address. 
See:
https://github.com/devicetree-org/devicetree-specification/releases

It seems like a common issue in the kernel as I see many similar users.

Regards
Dong Aisheng

> --
> Regards,
> Leonard
