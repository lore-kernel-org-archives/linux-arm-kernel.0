From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Aug 2013 15:37:20 +0200
Subject: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
In-Reply-To: <20130807111354.5e29a74c@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
 <20130807111354.5e29a74c@skate>
Message-ID: <20130807133719.GA26302@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 11:13:54AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Thu, 25 Jul 2013 09:53:03 -0700, Thierry Reding wrote:
> 
> > I just noticed two minor issues, see below.
> > 
> > > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > [...]
> > > @@ -36,6 +36,8 @@ struct hw_pci {
> > >  					  resource_size_t start,
> > >  					  resource_size_t size,
> > >  					  resource_size_t align);
> > > +	void            (*add_bus)(struct pci_bus *bus);
> > > +	void            (*remove_bus)(struct pci_bus *bus);
> > 
> > This hunk...
> > 
> > > @@ -63,6 +65,8 @@ struct pci_sys_data {
> > >  					  resource_size_t start,
> > >  					  resource_size_t size,
> > >  					  resource_size_t align);
> > > +	void            (*add_bus)(struct pci_bus *bus);
> > > +	void            (*remove_bus)(struct pci_bus *bus);
> > >  	void		*private_data;	/* platform controller private data	*/
> > >  };
> > 
> > and this one use inconsistent indentation (spaces instead of tabs).
> 
> Hum, I must be missing something here. Looking at the patch you're
> quoting, and my code, I see one tab before 'void' in both cases, and
> spaces between 'void' and the (*function) in both cases.
> 
> Am I missing something here?

Perhaps I should've said "alignment" instead of "indentation" to make it
more explicit. All other members use tabs to separate the data type and
the field name, while the lines that you add use spaces.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/bb9e4d41/attachment.sig>
