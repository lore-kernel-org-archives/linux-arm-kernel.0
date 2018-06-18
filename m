From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 18 Jun 2018 18:30:38 +0200
Subject: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
In-Reply-To: <1529337797.7211.4.camel@pengutronix.de>
References: <20180618154257.16919-1-manu@freebsd.org>
 <1529337797.7211.4.camel@pengutronix.de>
Message-ID: <20180618183038.c8ee3164ff62ab5e27535c5c@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jun 2018 18:03:17 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Am Montag, den 18.06.2018, 17:42 +0200 schrieb Emmanuel Vadot:
> > The RIoTboard debug uart is connected to serial1.
> > Add a chosen property in the DTS so OS knows what serial port to use for
> > the console.
> > 
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > ---
> > ?arch/arm/boot/dts/imx6dl-riotboard.dts | 4 ++++
> > ?1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
> > index 2e98c92adff7..315d2ae6fa45 100644
> > --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
> > +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
> > @@ -19,6 +19,10 @@
> > > ?		reg = <0x10000000 0x40000000>;
> > > ?	};
> > ?
> > > +	chosen {
> > +		stdout-path = "serial1:115200n8";
> 
> If there a reason to deviate from the "stdout-path = &uart1;" notation
> used by other i.MX boards?
> 
> Regards,
> Lucas

 This is, AFAIK, the proper way to specify the stdout-path.
 See
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/chosen.txt#L31

 Cheers,

> > +	};
> > +
> > > ?	regulators {
> > > ?		compatible = "simple-bus";
> > > ?		#address-cells = <1>;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
