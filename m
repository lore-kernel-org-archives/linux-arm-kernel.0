From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 06:55:25 +0000
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56C7B6D25@IL-MB01.marvell.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <20130321214607.GC8431@obsidianresearch.com>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56C7B6D25@IL-MB01.marvell.com>
Message-ID: <201303220655.25882.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Lior Amsalem wrote:
> > From: Jason Gunthorpe [mailto:jgunthorpe at obsidianresearch.com]
> > Sent: Thursday, March 21, 2013 11:46 PM
> >
> > On Thu, Mar 21, 2013 at 11:35:21PM +0200, Lior Amsalem wrote:
> > 
> > > >  *) It would require Linux to change the internal registers address
> > > >     (for now the kernel relies on the bootloader). The problem is that
> > > >     we can't do it early enough to preserve the earlyprintk
> > > >     functionality. Maybe you have suggestions on how to achieve that?
> > >
> > > Please note that all registers and IOs are still 32bit, the 40bit
> > > extension is on the CPU to DRAM path (windows) only.
> > 
> > Ah, I did wonder, since Ezequiel's MBUS driver was the same as on prior
> > families. I guess it is also the case that all on board DMA and DMA from PCI-E
> > devices are restricted to the low 32 bits as well?
> 
> Correct, that's why we sets DMABOUNCE config.
> 

IIRC, DMABOUNCE does not work well in a multiplatform configuration. Have you tried
using swiotlb instead?

	Arnd
