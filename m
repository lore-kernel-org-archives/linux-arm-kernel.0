From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Sep 2017 16:26:24 +0000
Subject: [PATCH 4/8] ARM: dts: iwg22d: Enable SDHI0 controller
In-Reply-To: <20170915080530.GH3924@verge.net.au>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-5-git-send-email-chris.paterson2@renesas.com>
 <20170915080530.GH3924@verge.net.au>
Message-ID: <TY1PR06MB08952278EF3A13B4CDBD568CC0630@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Apologies for the delay in getting back to you.

> -----Original Message-----
> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 15 September 2017 09:06
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Fabrizio Castro <fabrizio.castro@bp.renesas.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 4/8] ARM: dts: iwg22d: Enable SDHI0 controller
>
> On Wed, Sep 13, 2017 at 06:05:37PM +0100, Chris Paterson wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Enable the SDHI0 controller on iWave RZ/G1E carrier board.
>
> ...
>
> > @@ -63,3 +88,15 @@
> >  micrel,led-mode = <1>;
> >  };
> >  };
> > +
> > +&sdhi0 {
> > +pinctrl-0 = <&sdhi0_pins>;
> > +pinctrl-1 = <&sdhi0_pins_uhs>;
> > +pinctrl-names = "default", "state_uhs";
> > +
> > +vmmc-supply = <&reg_3p3v>;
> > +vqmmc-supply = <&vccq_sdhi0>;
> > +cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
>
> I take that the absence of a wp-gpio means that that this is a ?SD slot.
> Could you help me by documenting this correctly on
> http://elinux.org/index.php?title=Renesas-MMC-Enabled-Speeds ?
>
> For some reason I thought that SDHI0 wasn't exposed at all, so I guess
> my reading of the documentation was incorrect.
>
>
> I think you also want sd-uhs-sdr50 here too.
> You can test it by removing the sd-uhs-sdr104 property.

Whilst playing with uhs properties I have noticed that with the version of the DT I was using I couldn't put sdhi0 into an uhs mode and that was down to the fact that the driver wasn't driving the regulator to 1.8V. This happens because (in my case) the power regulator gets probed after the sdhi does, and the sdhi code doesn't seem to deal with it. Am I the only one with this problem or is it a known problem?

Thanks,
Fabrizio

>
> > +sd-uhs-sdr104;
> > +status = "okay";
> > +};
> > --
> > 1.9.1
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
