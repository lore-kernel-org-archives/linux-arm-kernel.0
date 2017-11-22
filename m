From: greg@kroah.com (Greg KH)
Date: Wed, 22 Nov 2017 08:51:24 +0100
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
 <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
Message-ID: <20171122075124.GA26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:08:45AM -0600, Timur Tabi wrote:
> On 11/21/17 11:55 PM, Sinan Kaya wrote:
> > For places where domain number information is available, I extracted domain number
> > and added into pci_get_domain_bus_and_slot() call such as xen or bn drivers.
> 
> My suggestion is that you restrict your first patch set to only these
> patches.
> 
> > The assumption at this point is for pci_get_bus_and_slot() usages to be caught
> > in code-review.
> 
> How about this:
> 
> static inline struct pci_dev * __deprecated pci_get_bus_and_slot(unsigned
> int bus,
> 						   unsigned int devfn)
> {
> 	return pci_get_domain_bus_and_slot(0, bus, devfn);
> }

Ick, no, why?  What is wrong with removing this function as is?  Don't
mark something as __depreciated if there are no in-kernel users, just
delete it and move on.

If you have out-of-tree drivers, then yes, they can make a wrapper for
this function like this if they really feel the need, or they can get
their code merged :)

thanks,

greg k-h
