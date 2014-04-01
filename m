From: tthayer@altera.com (Thor Thayer - Sendmail)
Date: Tue, 1 Apr 2014 15:11:41 -0500
Subject: [PATCH 1/2] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <20140401052807.GN5052@pengutronix.de>
References: <1396303627-29198-1-git-send-email-tthayer@altera.com>
 <1396303627-29198-2-git-send-email-tthayer@altera.com>
 <20140401052807.GN5052@pengutronix.de>
Message-ID: <1396383101.20336.6.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-01 at 07:28 +0200, Steffen Trumtrar wrote:
> Hi!
> 
> On Mon, Mar 31, 2014 at 05:07:06PM -0500, tthayer at altera.com wrote:
> > From: Thor Thayer <tthayer@altera.com>
> > 
> > Addition of the Altera SDRAM controller bindings and device
> > tree changes to the Altera SoC project.
> >

<snip>

> > diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> > new file mode 100644
> > index 0000000..351ab7b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> > @@ -0,0 +1,14 @@
> > +Altera SOCFPGA SDRAM Controller
> > +
> > +Required properties:
> > +- compatible : "altr,sdr-ctl", "syscon";
> > +                Note that syscon is invoked for this device to support the FPGA
> > +		bridge driver and possibly other devices in the future.  See
> > +		also Documentation/devicetree/bindings/mfd/syscon.txt
> 
> This note is really linux specific (and specific to some vendor kernel driver
> for that matter). I think you should remove that.

Hi Steffen. Are you asking for the path to syscon.txt to be removed or
the entire note? 
The note is explaining why the "syscon" tag is used for this Altera IP
block (registers shared between multiple drivers).
Thanks for the clarification.

> 
> > +- reg : Should contain 1 register ranges(address and length)
> > +
> > +Example:
> > +	sdrctl at 0xffc25000 {
> > +		compatible = "altr,sdr-ctl", "syscon";
> > +		reg = <0xffc25000 0x1000>;
> > +	};
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index 9e78c1d..3634de7 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -528,6 +528,11 @@
> >  			reg-io-width = <4>;
> >  		};
> >  
> > +		sdrctl at 0xffc25000 {
> > +			compatible = "altr,sdr-ctl", "syscon";
> > +			reg = <0xffc25000 0x1000>;
> > +		};
> > +
> >  		rstmgr at ffd05000 {
> >  			compatible = "altr,rst-mgr";
> >  			reg = <0xffd05000 0x1000>;
> 
> Regards,
> Steffen
> 
