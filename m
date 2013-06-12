From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 12 Jun 2013 13:16:42 -0700
Subject: [PATCH v2 3/3] arm: dt: zynq: Add support for the zed platform
In-Reply-To: <20130612193358.GA21585@pengutronix.de>
References: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1371055268-32337-4-git-send-email-soren.brinkmann@xilinx.com>
 <20130612182345.GA1656@pengutronix.de>
 <2433e1d1-7d2e-4b23-a76e-2085e3aef1a6@DB9EHSMHS010.ehs.local>
 <20130612193358.GA21585@pengutronix.de>
Message-ID: <d7057a7e-fc92-4e24-bf7b-137e873f871b@VA3EHSMHS011.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 09:33:58PM +0200, Steffen Trumtrar wrote:
> On Wed, Jun 12, 2013 at 11:26:34AM -0700, S?ren Brinkmann wrote:
> > On Wed, Jun 12, 2013 at 08:23:45PM +0200, Steffen Trumtrar wrote:
> > > On Wed, Jun 12, 2013 at 09:41:08AM -0700, Soren Brinkmann wrote:
> > > > Add a DT fragment for the Zed Zynq platform and a corresponding
> > > > target to the Makefile
> > > > 
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > ---
> > > > I used the 'xlnx,...' compat strings since it seems this is what is
> > > > used in the Xilinx and Digilent vendor trees.
> > > > 
> > > > +/include/ "zynq-7000.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Zynq Zed Development Board";
> > > > +	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
> > > > +
> > > > +	memory {
> > > > +		device_type = "memory";
> > > > +		reg = <0 0x20000000>;
> > > > +	};
> > > > +
> > > > +	chosen {
> > > > +		bootargs = "console=ttyPS1,115200 earlyprintk";
> > > > +	};
> > > > +
> > > > +};
> > > 
> > > Hi!
> > > 
> > > This looks a little bit to basic. No?! Not even an UART?
> > The UART is imported from the common zynq-7000.dtsi.
> 
> Hm, you are actually right, although I think that you shouldn't be.
> It is possible to NOT use the UARTs, isn't it? So, default on for both UARTs is wrong.
Well, in that case the dtsi has to be fixed to add the 'status = "disabled"
property to the UARTs which then can be overridden in the board dts files
as needed. I guess I'll prepare another patch for a v3 for adding status
properties to the UART nodes.

> 
> > 
> > > The compatible should include digilent or avnet. Digilent only sells to academic
> > > customers, Avnet doesn't.
> > I don't care at all. So, who makes the decision which one is the correct
> > one? Actually we could even drop the zed specific one completely and go
> > with 'xlnx,zynq-7000' only.
> 
> I'm okay with that.
Okay, let's wait a little and see if there are other opinions and then I
can prepare a v3.

	S?ren
