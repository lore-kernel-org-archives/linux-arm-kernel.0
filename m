From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 27 Jul 2010 12:42:04 +0300
Subject: [PATCH 2/5] Add 'code' parameter for hook_fault_code()
In-Reply-To: <20100727093537.GA7846@n2100.arm.linux.org.uk>
References: <cover.1279529223.git.kirill@shutemov.name>
	<182e37fa369c926c23f21f6a06426afb8a5b6f81.1279529223.git.kirill@shutemov.name>
	<20100727093537.GA7846@n2100.arm.linux.org.uk>
Message-ID: <20100727094204.GA3177@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 10:35:37AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 19, 2010 at 11:53:22AM +0300, Kirill A. Shutsemov wrote:
> > diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
> > index 90771ca..853fd90 100644
> > --- a/arch/arm/mach-ixp2000/pci.c
> > +++ b/arch/arm/mach-ixp2000/pci.c
> > @@ -209,7 +209,7 @@ ixp2000_pci_preinit(void)
> >  			"the needed workaround has not been configured in");
> >  #endif
> >  
> > -	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS,
> > +	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS, 0
> >  				"PCI config cycle to non-existent device");
> 
> This is broken - can you submit a fixed version please?

Done.

-- 
 Kirill A. Shutemov
