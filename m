From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Jan 2017 12:52:01 +0100
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
In-Reply-To: <e085504e-74fd-e8be-8287-4baef88551c9@huawei.com>
References: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
 <6092525.UgRCY3dpzP@wuerfel>
 <e085504e-74fd-e8be-8287-4baef88551c9@huawei.com>
Message-ID: <1882721.jqIYnAaWfQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 9, 2017 10:59:47 AM CET John Garry wrote:
> On 06/01/2017 11:24, Arnd Bergmann wrote:
> > On Friday, January 6, 2017 11:15:22 AM CET John Garry wrote:
> >
> > Probably nobody thought about this properly in the Linux drivers. The
> > ARMv8 ARM sounds correct here.
> >
> > I/O space may have the same issue, as it also requires non-posted
> > accesses.
> 
> Right, so our HW team's recommendation - from ARM's memory model and 
> also PCIe order model - is that not only config space but also PCIe 
> memory mapped IO has the same attribute (nE).

Just to be sure we are talking about the same thing: "PCIe memory
mapped IO" could refer to either PCI I/O space or PCI memory space.

As far as I can tell, PCI memory space should *not* be using the nE
attribute, while PCI I/O space and PCI config space should.
Does this match what your HW team recomments?

	Arnd
