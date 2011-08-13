From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 13 Aug 2011 20:22:12 +0800
Subject: Tegra pinmux Device Tree support
In-Reply-To: <CAOesGMjH8hZSAXvDZ6ADO-dtFNecRYC5GsfRiAeV8KMRG=JTkQ@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
	<20110809173428.GB32195@ponder.secretlab.ca>
	<CAOesGMjH8hZSAXvDZ6ADO-dtFNecRYC5GsfRiAeV8KMRG=JTkQ@mail.gmail.com>
Message-ID: <20110813122211.GB7244@S2100-06.ap.freescale.net>
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
> 
> I know it's a hairy problem to deal with one compact pinmux
> representation that fits all needs. Maybe making it overly generic is
> the wrong way to go about it, and let each implementation define what
> it needs? That way the simpler implementations can do something
> reasonably simple without having to deal with the overly complex
> options of the (over?) generalized platforms out there.
> 
Though I was part of the talk on Linaro Connect about register-write
binding, I still like the soc specific binding a little bit more.
Let's see if we can eventually change Grant's mind with more people
on the other way :)

-- 
Regards,
Shawn
