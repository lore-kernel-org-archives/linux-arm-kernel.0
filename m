From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Mar 2013 16:21:02 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
References: <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130313222102.GA28336@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 11:02:35PM +0100, Thierry Reding wrote:
 
> Does that look about correct?

By my reading of the spec the entries in ranges should not
have the b,d,f bits set..

Although it is not a big stretch to include them..

> Now the code will actually match the first entry and assume that it
> represents the non-prefetchable 32-bit memory space and program the
> controller to forward accesses to the 0x80000000-0x80000fff region
> as PCI memory write transactions.

Yah, it makes a mess of determining the host bridge aperture. Require
the aperture to be first/last?

Make use of the 2nd dword?

Go back to the idea of the top level reg?

Jason
