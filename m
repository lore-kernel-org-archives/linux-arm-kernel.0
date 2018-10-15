From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 15 Oct 2018 07:30:09 +0000
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
Message-ID: <52eaa4ac563ad5114ebd99b286cdbe0495dba7ec.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-10-14 at 20:13 -0300, Fabio Estevam wrote:
> > +               imx8qx-pm {
> > +                       compatible = "fsl,scu-pd";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +
> > +                       pd_lsio: lsio-power-domain {
> > +                               #power-domain-cells = <0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               pd_lsio_pwm0: lsio-pwm0 at 191 {
> > +                                       reg = <191>;
> 
> The number after @ is in hex, so the reg property should be 0x191.

These are SC_R_* resource ids from include/linux/firmware/imx/types.h
and they are almost everywhere referenced as decimals.

Is this really not acceptable for DT?

--
Regards,
Leonard
