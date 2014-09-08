From: rric@kernel.org (Robert Richter)
Date: Mon, 8 Sep 2014 09:54:59 +0200
Subject: [PATCH v2 3/4] arm64, thunder: Document devicetree bindings for
 Cavium Thunder SoC
In-Reply-To: <20140905093932.GI2172@leverpostej>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <1409903205-2762-4-git-send-email-rric@kernel.org>
 <20140905084200.GE13515@arm.com>
 <20140905093222.GS4703@rric.localhost>
 <20140905093932.GI2172@leverpostej>
Message-ID: <20140908075459.GW4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.09.14 10:39:33, Mark Rutland wrote:
> On Fri, Sep 05, 2014 at 10:32:22AM +0100, Robert Richter wrote:
> > On 05.09.14 09:42:00, Will Deacon wrote:
> > > On Fri, Sep 05, 2014 at 08:46:44AM +0100, Robert Richter wrote:
> > > > From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> > > > 
> > > > This patch adds documentation for the devicetree bindings used by the
> > > > DT files of Cavium Thunder SoC platforms.
> > > > 
> > > > Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> > > > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/cavium-thunder.txt | 10 ++++++++++
> > > >  Documentation/devicetree/bindings/arm/cpus.txt           |  1 +
> > > >  2 files changed, 11 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
> > > > new file mode 100644
> > > > index 000000000000..6f63a5866902
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
> > > > @@ -0,0 +1,10 @@
> > > > +Cavium Thunder platform device tree bindings
> > > > +--------------------------------------------
> > > > +
> > > > +Boards with Cavium's Thunder SoC shall have following properties.
> > > > +
> > > > +Root Node
> > > > +---------
> > > > +Required root node properties:
> > > > +
> > > > +  - compatible = "cavium,thunder-88xx";
> > > 
> > > Is this file necessary? We don't have one for xgene afaict.
> > 
> > Hmm, looking at Documentation/devicetree/bindings/arm/calxeda.txt
> > there is something similar.
> > 
> > I am fine with both, keeping or removing it.
> > 
> > Would leave this to the DT maintainers.
> 
> Having a required root node compatible is fine, though I would only
> expect it to be necessary for errata workarounds if we have no other way
> of detecting things.

Ok, will keep the change.

> That said, compatible strings shouldn't have wildcards, so
> "cavium,thunder-88xx" should be replaced with something more specific.
> Later boards can claim compatibility with that (but should have their
> own strings too).

88xx is not a wildcard for chips, there are no chips named 8800 or
whatever, instead we have e.g. 87xx. That said, 88xx is the specific
name of the soc and the first reference board. If there will be other
boards with the same soc, it should have its own name but should be
compatible with cavium,thunder-88xx. Later soc revisions will get a
different name than thunder-88xx for differentiation.

-Robert
