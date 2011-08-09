From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 9 Aug 2011 14:43:43 -0600
Subject: Tegra pinmux Device Tree support
In-Reply-To: <20110809201815.GA21684@pulham.picochip.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
	<20110809173428.GB32195@ponder.secretlab.ca>
	<20110809201815.GA21684@pulham.picochip.com>
Message-ID: <20110809204343.GA11568@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 09:18:15PM +0100, Jamie Iles wrote:
> Hi Grant,
> 
> On Tue, Aug 09, 2011 at 11:34:28AM -0600, Grant Likely wrote:
> > We talked about this a bit at Linaro connect.  Outside of the more
> > complex runtime-reconfiguration of pin mux, there is a general need
> > for arbitrary initialization sequences to registers.  Also, pretty
> > much exactly what you need for tegra is needed for imx, omap and many
> > others.  The though was, rather than trying to come up with some kind
> > of pinmux-specific binding for pin states, which could end up being
> > very verbose if everything was split out into properties, we could
> > instead have a binding for register initialization sequences.
> > Something like this:
> > 
> > 	pinmux-initseq = <reg1 value1> <reg1 value2> ...;
> > 
> > And then add some macros for DTC to make it easier to define things
> > like pinmux setup tables.  Although the binding above is probably too
> > simple and naive.
> 
> Unfortunately we have devices where the pinmux registers aren't directly 
> memory mapped so I'm not sure that this would work for our devices 
> (which admittedly don't have a friendly muxing configuration...).  We 
> don't have a single way of muxing pins so at the moment we have a fairly 
> hideous set of structures and macros to allow us to create smallish 
> definitions of pins, but I can't see a nice way to express this in the 
> DT.
> 
> At the moment I have a simple pinmux API that takes the pin name and 
> setting name as strings, so I was thinking for a simple binding (for 
> configuration) I could have something like:
> 
> 	pinmux {
> 		pinmux-decode0 = "decode";
> 		pinmux-decode1 = "gpio";
> 	};
> 
> I remember in another thread you mentioned the possibility of building 
> some tables and embedding the binary data in the DT, but that has 
> potential problems with versioning of the structures.

Structure/binding versioning is easy.  If it really is necessary to
change the binding in an incompatible way, then change the compatible
value too.

g.
