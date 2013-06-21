From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 13:23:46 +0800
Subject: [PATCH 5/6] ARM: dts: imx27 cpufreq-cpu0 frequencies
In-Reply-To: <1371790493.32418815@f415.i.mail.ru>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-6-git-send-email-mpa@pengutronix.de>
 <20130621024406.GB24268@S2101-09.ap.freescale.net>
 <1371790493.32418815@f415.i.mail.ru>
Message-ID: <20130621052344.GA25633@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 08:54:53AM +0400, Alexander Shiyan wrote:
> > On Thu, Jun 20, 2013 at 04:50:14PM +0200, Markus Pargmann wrote:
> > > +	cpus {
> > > +		#size-cells = <0>;
> > > +		#address-cells = <1>;
> > > +
> > > +		cpu at 0 {
> > > +			device_type = "cpu";
> > > +			compatible = "fsl,imx27", "arm,arm926ejs";
> > 
> > From what Documentation/devicetree/bindings/arm/cpus.txt tells, it
> > should be "arm,arm926".  Also, why do you put "fsl,imx27" there?
> > "imx27" is a SoC name not cpu core.
> 
> I think Markus take this ARM property from one of existing DTS.
> 
> shc at shc /home/git/linux-mx27/arch/arm/boot/dts $ grep arm926 *.dtsi
> at91sam9260.dtsi:                       compatible = "arm,arm926ejs";
> at91sam9263.dtsi:                       compatible = "arm,arm926ejs";
> at91sam9g45.dtsi:                       compatible = "arm,arm926ejs";
> at91sam9n12.dtsi:                       compatible = "arm,arm926ejs";
> at91sam9x5.dtsi:                        compatible = "arm,arm926ejs";
> imx23.dtsi:                     compatible = "arm,arm926ejs";
> imx28.dtsi:                     compatible = "arm,arm926ejs";
> lpc32xx.dtsi:                   compatible = "arm,arm926ejs";
> s3c2416.dtsi:                   compatible = "arm,arm926ejs";
> spear3xx.dtsi:                  compatible = "arm,arm926ejs";
> spear600.dtsi:                  compatible = "arm,arm926ejs";
> wm8505.dtsi:                    compatible = "arm,arm926ejs";
> 
> So, documentation need to be updated or these values should be fixed.
> Another solution  is specify compatible string as:
> compatible = "arm,arm926ejs", "arm,arm926";
> What you think about this?

I assume that the compatible string in the binding doc has been reviewed
and agreed by people, so we should fix the existing users before kernel
starts using it to for matching something.

Lorenzo, comment?

Shawn
