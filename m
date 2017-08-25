From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 25 Aug 2017 08:57:06 -0500
Subject: [PATCH v4 3/4] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
In-Reply-To: <20170825021132.GA104845@google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-4-jeffy.chen@rock-chips.com>
 <20170824165353.GL31858@bhelgaas-glaptop.roam.corp.google.com>
 <20170825021132.GA104845@google.com>
Message-ID: <20170825135706.GB1304@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 07:11:32PM -0700, Brian Norris wrote:
> On Thu, Aug 24, 2017 at 11:53:54AM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 22, 2017 at 11:19:33AM +0800, Jeffy Chen wrote:
> > > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > index 5678be82530d..9f6504129e80 100644
> > > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > @@ -20,10 +20,13 @@ Required properties:
> > >  - msi-map: Maps a Requester ID to an MSI controller and associated
> > >  	msi-specifier data. See ./pci-msi.txt
> > >  - interrupts: Three interrupt entries must be specified.
> > > -- interrupt-names: Must include the following names
> > > -	- "sys"
> > > -	- "legacy"
> > > -	- "client"
> > > +- interrupt-names: Include the following names
> > > +	Required:
> > > +		- "sys"
> > > +		- "legacy"
> > > +		- "client"
> > > +	Optional:
> > > +		- "wake"
> > 
> > Why is there no other PCI binding that includes "wake" as an
> > interrupt-name?  This feels like something that should be fairly
> > common across host controllers.  I don't want a Rockport-specific
> 
> s/port/chip/ :)

I visited Rockport this summer, guess I had it on the brain :)

> > DT description if it could be made more general.
> 
> I'm not sure we can really answer that question ("why do no other PCI
> bindings have this?"). But one guess would be that every other
> controller uses only beacon wake.
> 
> It would be OK with me if we made a blanket statement that a controller
> with a "wake" interrupt means PCI WAKE# (per the specification). It's
> possible this could even be stuck into some generic PCI/DT code
> eventually. (I don't think we have a really good place for this today.)

I'd just like every controller that uses WAKE# to use the same name in
DT.  Maybe all that means for now is mentioning it in
Documentation/devicetree/bindings/pci/pci.txt instead of (or in
addition to) Documentation/devicetree/bindings/pci/rockchip-pcie.txt
