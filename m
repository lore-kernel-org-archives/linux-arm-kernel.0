From: atull@opensource.altera.com (atull)
Date: Tue, 13 Oct 2015 21:46:15 +0200
Subject: [PATCH] ARM: socfpga: dts: add fpga manager
In-Reply-To: <alpine.DEB.2.02.1510131412500.3527@linux-builds1>
References: <1444760900-1373-1-git-send-email-atull@opensource.altera.com>
 <20151013185750.GB17155@pengutronix.de>
 <alpine.DEB.2.02.1510131412500.3527@linux-builds1>
Message-ID: <alpine.DEB.2.10.1510132142250.2247@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Oct 2015, Dinh Nguyen wrote:

> On Tue, 13 Oct 2015, Steffen Trumtrar wrote:
> 
> > Hi Alan!
> > 
> > On Tue, Oct 13, 2015 at 01:28:20PM -0500, atull at opensource.altera.com wrote:
> > > From: Alan Tull <atull@opensource.altera.com>
> > > 
> > > Add FPGA manager to device tree for SoCFPGA.
> > > 
> > > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > > ---
> > >  arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > > index 314e589..e37ba11 100644
> > > --- a/arch/arm/boot/dts/socfpga.dtsi
> > > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > > @@ -834,5 +834,12 @@
> > >  			compatible = "altr,sys-mgr", "syscon";
> > >  			reg = <0xffd08000 0x4000>;
> > >  		};
> > > +
> > > +		hps_0_fpgamgr: fpgamgr at 0xff706000 {
> > > +			compatible = "altr,socfpga-fpga-mgr";
> > > +			reg = <0xFF706000 0x1000
> > > +			       0xFFB90000 0x1000>;
> > > +			interrupts = <0 175 4>;
> > > +		};
> > >  	};
> > >  };
> > 
> > Please keep the format in line with the rest of the file:
> > Hexvalues are lowercase and no 0x after the "fpgamgr@".
> > I'd say "And please put the node in its proper position
> > according to its address", but I see just now, that the
> > dtsi is all messed up right now anyway :-(
> > 

Hi Steffen,

Thanks for the review.  I'll fix these things you pointed out.

"all messed up" seems kind of unclear and overstated here.  From the 
context, I assume you mean that you are pointing out that the nodes
are in more or less alphatetical order and not in order of address.  Is 
that what you mean or is the dtsi really all messed up?

Alan

> 
> How so? Patches are welcomed!
> 
> Please fix the "fpgamgr@" and lower case the hex values. But I would prefer the
> nodes to be in alphabetical order.
> 
> Also, you need to document the "altr,socfpga-fpga-mgr".
> 
> Thanks,
> Dinh
> > Regards,
> > Steffen
> > 
> > -- 
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> > 
> 
> BR,
> Dinh
> 
