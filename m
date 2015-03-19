From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Mar 2015 16:46:18 +0000 (UTC)
Subject: [PATCHv2 3/3] Documentation: DT bindings: Tegra AHB: note base
 address change
In-Reply-To: <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
References: <20150317083221.32662.14647.stgit@baseline>
 <20150317083221.32662.96822.stgit@baseline>
 <20150317103806.GU8656@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1503191525450.9480@utopia.booyaka.com>
 <550AEE6B.5080301@wwwdotorg.org>
 <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1503191645350.9480@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Paul Walmsley wrote:

> On Thu, 19 Mar 2015, Stephen Warren wrote:
> 
> > On 03/19/2015 09:26 AM, Paul Walmsley wrote:
> > > On Tue, 17 Mar 2015, Russell King - ARM Linux wrote:
> > > 
> > > > On Tue, Mar 17, 2015 at 01:32:21AM -0700, Paul Walmsley wrote:
> > > > >   Required properties:
> > > > >   - compatible : For Tegra20, must contain "nvidia,tegra20-ahb".  For
> > > > > -  Tegra30, must contain "nvidia,tegra30-ahb".  Otherwise, must contain
> > > > > -  '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra124,
> > > > > -  tegra132, or tegra210.
> > > > > -- reg : Should contain 1 register ranges(address and length)
> > > > > +  Tegra30, must contain "nvidia,tegra30-ahb".  For Tegra114 and
> > > > > Tegra124, must
> > > > > +  contain '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is
> > > > > tegra114
> > > > > +  or tegra124.  For Tegra132, the compatible string must contain
> > > > > +  "nvidia,tegra132-ahb".
> > > > > +
> > > > > +- reg : Should contain 1 register ranges(address and length).  On
> > > > > Tegra20,
> > > > > +  Tegra30, Tegra114, and Tegra124 chips, the low byte of the physical
> > > > > base
> > > > > +  address of the IP block must end in 0x04.  On DT files for later
> > > > > chips, the
> > > > > +  actual hardware base address of the IP block should be used.
> > > > 
> > > > You could check that in the driver.  If you can check it in the driver,
> > > > you can also decide to ignore it if it were offset by 0x04 (possibly
> > > > printing a warning.)  That opens up the ability to fix the older Tegra
> > > > DT files going forward while still remaining compatible with existing
> > > > DT files, and avoiding the need for a complex note about this.
> > > 
> > > That's fine, I'll do that and drop this patch.
> > 
> > Don't we still want to update the DT binding documentation to state what the
> > preferred base address (or at least set of legal base addresses) is/are?
> 
> As far as I know, the DT binding documents are intended to be a 
> reference for IP block integration data like base addresses. 

The above is missing an important word: it should have read "are _not_ 
intended"


- Paul
