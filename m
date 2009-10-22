From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Oct 2009 14:19:47 -0400 (EDT)
Subject: [PATCHv3] [ARM] kirkwood: combine support for openrd base/client
	support
In-Reply-To: <20091022110436.GF6085@chipmunk>
References: <pbh5r6-os7.ln1@chipmunk.wormnet.eu>
	<20091022124756.56e89d7a@marrow.netinsight.se>
	<20091022110436.GF6085@chipmunk>
Message-ID: <alpine.LFD.2.00.0910221412360.21460@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2009, Alexander Clouter wrote:

> Hi,
> 
> * Simon Kagstrom <simon.kagstrom@netinsight.net> [2009-10-22 12:47:56+0200]:
> >
> > On Thu, 22 Oct 2009 09:22:49 +0100 Alexander Clouter <alex@digriz.org.uk> wrote:
> > 
> > > +static int __init openrd_pci_init(void)
> > > +{
> > > +	kirkwood_pcie_init();
> > 
> > I think you should do
> > 
> > 	if (machine_is_openrd_base() || machine_is_openrd_client())
> > 		kirkwood_pcie_init();
> > 
> > here instead since there might be other boards configured as well where
> > this shouldn't be done (e.g., a build with both sheevaplug and the
> > OpenRDs).
> > 
> It's called 'openrd-setup.c' not 'sheevaplug-setup.c' :)

So?

> The SheevaPlug's do not use this at all ('MACHINE_START(SHEEVAPLUG, 
> ...)' is not to be seen in there), they already have their own file.

The openrd_pci_init() is still called with a subsys_initcall() 
registration.  That would be invoked on a SheevaPlug as well if you have 
a kernel that supports them both.

> If someone 
> wants to merge the SheevaPlug's into here too they can cross that bridge 
> themselves.

No way.  I'll bomb the bridge beforehand.  There should be a balance 
between consolidation and abstraction.


Nicolas
