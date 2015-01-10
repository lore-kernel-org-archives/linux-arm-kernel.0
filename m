From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 10 Jan 2015 17:33:49 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150109165204.3d0d3d99@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150109165204.3d0d3d99@free-electrons.com>
Message-ID: <20150110163349.GB5392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 04:52:04PM +0100, Thomas Petazzoni wrote:
> Hello Andrew,
> 
> On Tue, 30 Dec 2014 13:43:41 +0100, Thomas Petazzoni wrote:
> 
> > Michal Mazur (1):
> >   bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x
> > 
> > Thomas Petazzoni (5):
> >   dt: bindings: update mvebu-mbus DT binding with new compatible
> >     properties
> >   ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada
> >     38x
> >   bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus
> >     bridge window
> >   bus: mvebu-mbus: use automatic I/O synchronization barriers
> >   ARM: mvebu: use arm_coherent_dma_ops
> 
> Would it be possible to get those patches applied?

Hi Thomas

While we are discussing the fate of these patches, i thought i would
throw them into for-next for some testing. But i get a merge
conflict. This is caused by the re-arranged ordering of the patches.

Can you move:

bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus
bridge window

to after the i/o sync barriers fixes.

   Thanks
	Andrew
