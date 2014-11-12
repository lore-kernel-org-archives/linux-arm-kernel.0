From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Nov 2014 15:38:26 +0100
Subject: [RFC PATCH v2] drivers: pci: move PCI domain assignment to
 generic PCI code
In-Reply-To: <20141112141429.GF6759@red-moon>
References: <1415637706-2195-1-git-send-email-lorenzo.pieralisi@arm.com>
 <176983067.8qgFVmI6qY@wuerfel> <20141112141429.GF6759@red-moon>
Message-ID: <2433793.KkIZdJTcBW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014 14:14:29 Lorenzo Pieralisi wrote:
> > 
> > Since this is now in the file in which it gets called, you can mark the
> > function itself as 'static' and remove the extern declaration and inline
> > wrapper from the header file. You can also avoid the #ifdef by doing
> 
> It is not, it is in driver/pci/pci.c, it is called in probe.c.
> 
> Maybe I can move the function to probe.c, but this would leave the
> domain handling in two separate files.
> 
> I can't remove the #ifdeffery in that domain_nr in pci_bus is #ifdeffed
> too, unless I remove that #ifdef and I compile it in all the time.
> 

Right, I see. Unless Bjorn has some other preference, I'd just leave it
with your current version then.

	Arnd
