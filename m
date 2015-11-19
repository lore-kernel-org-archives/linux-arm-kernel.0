From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Nov 2015 17:03:28 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1447846576.3144.63.camel@pengutronix.de>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <201511181232.42446.marex@denx.de> <1447846576.3144.63.camel@pengutronix.de>
Message-ID: <201511191703.29104.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 at 12:36:16 PM, Lucas Stach wrote:
> Am Mittwoch, den 18.11.2015, 12:32 +0100 schrieb Marek Vasut:
> > On Wednesday, November 18, 2015 at 12:25:58 PM, Lucas Stach wrote:
> > > Am Mittwoch, den 18.11.2015, 11:35 +0100 schrieb Marek Vasut:
> > > > On Wednesday, November 18, 2015 at 11:10:12 AM, Lucas Stach wrote:
> > > > > Hi Marek,
> 
> [...]
> 
> > > > [...]
> > > > 
> > > > > > +&ecspi3 {
> > > > > > +	pinctrl-names = "default";
> > > > > > +	pinctrl-0 = <&pinctrl_ecspi3_novena>;
> > > > > > +	fsl,spi-num-chipselects = <3>;
> > > > > > +	status = "okay";
> > > > > > +
> > > > > > +	spidev at 0 {
> > > > > > +		compatible = "spidev";
> > > > > 
> > > > > This will explode on a new kernel. Specifying spidev without using
> > > > > a more specific compatible will trigger a WARN_ON(), as it's
> > > > > considered bad style.
> > > > 
> > > > Oh, looks like imx_v6_v7_defconfig didn't have SPIDEV active, which
> > > > is why I didn't catch it during my last test, dang.
> > > > 
> > > > This SPI interface is routed into the FPGA, so what do you suggest I
> > > > put in the compatible string? There is no other sensible driver for
> > > > the peripheral, since the peripheral can be anything.
> > > 
> > > I'm not really the right person to ask for that, but I would guess that
> > > inventing a "novena,fpga-spi" compatible or something like that and
> > > adding it to the spidev driver would be the right thing to do.
> > 
> > So what's the rationale behind generic "spidev" being bad ? In my mind,
> > it is much better to use generic driver and generic compatible prop
> > "spidev" than to generate many one-off compatible props and have a
> > driver with a list of all of those.
> 
> From the commit log:
> 
> "Since spidev is a detail of how Linux controls a device rather than a
> description of the hardware in the system we should never have a node
> described as "spidev" in DT, any SPI device could be a spidev so this is
> just not a useful description."
> 
> If you want to know about the details you would have to discuss this
> with Mark Brown.

I see, thanks for the clarification. I think I will drop this spidev for
now and add it once/if it's really needed. I think this might be much
better than poluting the spidev driver with yet another compat string.
What do you say ?

Best regards,
Marek Vasut
