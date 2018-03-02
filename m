From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Mar 2018 15:44:20 +0100
Subject: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
In-Reply-To: <20180302142537.25764c8e@jawa>
References: <20180302121750.12865-1-lukma@denx.de>
 <20180302125159.gufvhyy4ipyunmil@pengutronix.de>
 <20180302142537.25764c8e@jawa>
Message-ID: <20180302144420.37trllgposf4yet3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:25:37PM +0100, Lukasz Majewski wrote:
> Hi Sascha,
> 
> > Hi Lukasz,
> > 
> > On Fri, Mar 02, 2018 at 01:17:50PM +0100, Lukasz Majewski wrote:
> > > This commit adds device tree description of K+P's TPC board.  
> > 
> > Can we get a hint what this board is? I assume this one:
> > 
> > Technologic Systems' Full i.MX6 Portfolio Including SBC, COM, and
> > Touch Panel PCs
> 
> I just took other imx6q boards as an example - e.g. 
> 
> 420127e5a5b53ff2cb5effaa781aed93709b09bb
> 
> Generally, descriptions of DTSes are rather short and simple.
> 
> > 
> > Anyway, future developers are thankful if they have the information
> > around when they have to work on that file or have to decide if it is
> > to be removed.
> 
> IMHO, there is plenty of information around (iMX6 Quad SoC, with
> components described in dts).

There may be future changes necessary which may be done by people who do
not know which hardware this. For them it will be convenient to be able
to search for the hardware and maybe even find a schematics. Anyway, it
will just help to have that information around.

> > > +&can1 {
> > > +	status = "disabled";
> > > +};
> > > +
> > > +&can2 {
> > > +	status = "disabled";
> > > +};  
> > 
> > These are not enabled in your base dtsi, so no need to disabled it
> > here.
> 
> But they can be enabled if needed.

Yes, they can, but that still doesn't make these node references necessary.
If I read this it seems to me that you explicitly want to disable these
nodes. A reader can't know you add them for convenience here.

> > > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > > b/arch/arm/boot/dts/imx6q-kp.dtsi new file mode 100644
> > > index 000000000000..47a10fb1d46b
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > > +
> > > +	memory: memory {
> > > +		reg = <0x10000000 0x40000000>;
> > > +	};
> > > +
> > > +	pwm-buzzer {
> > > +		compatible = "pwm-backlight";  
> > 
> > What is it? A backlight or a buzzer?
> 
> It is a buzzer, which is controlled by PWM.

Then you should bind the pwm-beeper driver to it, not a backlight.

Regards,
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
