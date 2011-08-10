From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 10 Aug 2011 11:23:49 +1000
Subject: Tegra pinmux Device Tree support
In-Reply-To: <CAOesGMjH8hZSAXvDZ6ADO-dtFNecRYC5GsfRiAeV8KMRG=JTkQ@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
	<20110809173428.GB32195@ponder.secretlab.ca>
	<CAOesGMjH8hZSAXvDZ6ADO-dtFNecRYC5GsfRiAeV8KMRG=JTkQ@mail.gmail.com>
Message-ID: <20110810012349.GA23511@yookeroo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 10:44:29AM -0700, Olof Johansson wrote:
> On Tue, Aug 9, 2011 at 10:34 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > We talked about this a bit at Linaro connect. ?Outside of the more
> > complex runtime-reconfiguration of pin mux, there is a general need
> > for arbitrary initialization sequences to registers. ?Also, pretty
> > much exactly what you need for tegra is needed for imx, omap and many
> > others. ?The though was, rather than trying to come up with some kind
> > of pinmux-specific binding for pin states, which could end up being
> > very verbose if everything was split out into properties, we could
> > instead have a binding for register initialization sequences.
> > Something like this:
> >
> > ? ? ? ?pinmux-initseq = <reg1 value1> <reg1 value2> ...;
> >
> > And then add some macros for DTC to make it easier to define things
> > like pinmux setup tables. ?Although the binding above is probably too
> > simple and naive.
> 
> This seems to break the philosophy of what the device tree should do
> -- it should describe the hardware so that the driver will know how to
> program it, not include the code itself?

Arguably, yes, although it's a barrier that's been frequently broken
by Apple already.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
