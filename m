From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 22:45:28 +0200
Subject: [PATCH v2 4/5] PCI: generic: Correct, and avoid overflow,
 in bus_max calculation.
In-Reply-To: <1707525.QvfFzUYq4E@wuerfel>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
 <20150923193545.GZ7356@arm.com> <1707525.QvfFzUYq4E@wuerfel>
Message-ID: <2795004.Hn5xt30nZN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 September 2015 21:39:27 Arnd Bergmann wrote:
> On Wednesday 23 September 2015 20:35:45 Will Deacon wrote:
> > 
> > From what Lorenzo was saying, ACPI shares the interpretation that David is
> > implementing here and, given that the DT version seems to be subjective,
> > aligning this reg property with MMCFG seems to make sense.
> 
> We should then make it very clear in the binding that the driver
> is not allowed to actually map the registers for the buses outside
> of the bus-range, as that is highly unusual.

One more point here: I think ACPI does something different here,
it lists the base address of mmconfig space of the the PCI domain
that the host bridge belongs to. In contrast, in DT the 'reg'
property is defined as the registers belonging to the host bridge
itself, and the DT does not say anything about domains at all
(aside from the linux,pci-domain property that is not mandatory
and a Linux-specific extension).

	Arnd
