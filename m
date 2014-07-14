From: b.galvani@gmail.com (Beniamino Galvani)
Date: Mon, 14 Jul 2014 21:04:26 +0200
Subject: [PATCH] ARM: dts: rk3188-radxarock: add GPIO IR receiver node
In-Reply-To: <2390327.HZxnbJmfOO@diego>
References: <1405253401-15534-1-git-send-email-b.galvani@gmail.com>
 <2390327.HZxnbJmfOO@diego>
Message-ID: <20140714190355.GA16904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 02:37:40PM +0200, Heiko St?bner wrote:
> Am Sonntag, 13. Juli 2014, 14:10:01 schrieb Beniamino Galvani:
> > This adds a device tree node for the infrared receiver connected to a
> > GPIO pin on the Radxa Rock.
> > 
> > Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> > ---
> >  arch/arm/boot/dts/rk3188-radxarock.dts |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts
> > b/arch/arm/boot/dts/rk3188-radxarock.dts index 19d45b4..1d87bcb 100644
> > --- a/arch/arm/boot/dts/rk3188-radxarock.dts
> > +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
> > @@ -23,6 +23,13 @@
> >  		reg = <0x60000000 0x80000000>;
> >  	};
> > 
> > +	ir_recv: ir-receiver {
> > +		compatible = "gpio-ir-receiver";
> > +		gpios = <&gpio0 10 1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&ir_recv_pin>;
> > +	};
> > +
> 
> hmm, on second glance, I'm actually not sure if this shouldn't belong in the 
> soc subnode, like the gpio-keys and leds.

(adding devicetree mailing list)

I placed the IR receiver under the root node after looking at what
other boards do, for example:

  imx6dl-hummingboard.dts
  imx6qdl-cubox-i.dtsi
  dove-cubox.dts

On the other hand, if gpio-keys and leds are under the soc node
probably it makes sense to follow the same rule also for the IR
receiver.

Beniamino
