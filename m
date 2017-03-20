From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 10:24:04 +0000
Subject: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
In-Reply-To: <1489605496.4195.182.camel@infradead.org>
References: <1489598266.86622.12.camel@infradead.org>
 <20170315175353.GA29452@leverpostej>
 <1489605496.4195.182.camel@infradead.org>
Message-ID: <20170320102403.GC17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 07:18:16PM +0000, David Woodhouse wrote:
> On Wed, 2017-03-15 at 17:54 +0000, Mark Rutland wrote:
> > It's not so much "broken" as "not currently supported".
> 
> Yeah, I thought that when I inherited the commit, but didn't get as far
> as rephrasing it. Will do so.
> 
> > [...]
> > 
> > > 
> > > +#define HAVE_PCI_MMAP
> > > +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> > > +			???????enum pci_mmap_state mmap_state, int write_combine);
> > > +
> > Per the prior attempt at this [1], we only want to expose the sysfs
> > interface, and not the legacy procfs interface, and need the two
> > decoupled [2].
> 
> I do not like that idea. The procfs horridness is legacy, sure, but
> it's not actually an arch-specific interface. You get to mess with
> 'legacy' syscalls all you like on a new architecture, but there could
> exist arch-agnostic code which uses the procfs interface, surely?

Just to be clear here: I'm not against exposing the proc interface if
something actually needs it, but all the requests we've had for this have
been concerned only with the sysfs API. So I'd rather start with just that,
instead of exposing both and have new software written to the proc interface,
which we certainly want to discourage.

Will
