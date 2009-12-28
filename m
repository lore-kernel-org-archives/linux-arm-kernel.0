From: roman.tereshonkov@nokia.com (Roman)
Date: Mon, 28 Dec 2009 13:02:25 +0200
Subject: Amba device porting
In-Reply-To: <20091223165009.GA13900@n2100.arm.linux.org.uk>
References: <20091223101902.GA15537@nokia.com>
	<20091223165009.GA13900@n2100.arm.linux.org.uk>
Message-ID: <20091228110225.GB12341@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 05:50:09PM +0100, ext Russell King - ARM Linux wrote:
> On Wed, Dec 23, 2009 at 12:19:02PM +0200, Roman wrote:
> > Hi,
> > 
> > I planned to port the omap3 SDTI (Serial Debug Trace Interface) driver to amba based interface.
> > 
> > SDTI memory map is two parts composed:
> > 0x54500000 0x5450FFFF 4KB       SDTI module (configuration) - coresight based format.
> > 0x54510000 0x545FFFFF 1984KB    Reserved
> > 0x54600000 0x546FFFFF 1MB       SDTI module (window)
> > 
> > But amba interface seems to support only one memory region resource.
> 
> The 'amba' interface is more a primecell interface.  Is SDTI a primecell
> peripheral?  If not, then it shouldn't be using the AMBA "primecell" bus
> support.

Yes, SDTI can be considered as a PrimeCell IP.
SDTI is the Coresight component which is the subgroup of PrimeCell.

So my question is still valid.
How does the 'amba' interface handle the fragmented memory regions?
I understand that for the right Coresight IP it should not happen and the whole register space should be continous and ended by the Peripherial and Component Ids.
If I use SDTI module (window) memory region as a static definition inside driver will my patch be accepted?


Regards
Roman Tereshonkov
