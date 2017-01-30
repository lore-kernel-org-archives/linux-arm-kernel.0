From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 30 Jan 2017 09:51:46 -0700
Subject: [PATCH] PCI: mvebu: Handle changes to the bridge windows while
 enabled
In-Reply-To: <20170130154136.GR20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20161212183020.GA30274@obsidianresearch.com>
 <20170130154136.GR20550@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170130165146.GA29502@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 09:41:36AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 12, 2016 at 11:30:20AM -0700, Jason Gunthorpe wrote:
> > The PCI core will write to the bridge window config multiple times
> > while they are enabled. This can lead to mbus failures like:
> > 
> >  mvebu_mbus: cannot add window '4:e8', conflicts with another window
> >  mvebu-pcie mbus:pex at e0000000: Could not create MBus window at [mem 0xe0000000-0xe00fffff]: -22
> > 
> > For me this is happening during a hotplug cycle. The PCI core is
> > not changing the values, just writing them twice while active.
> > 
> > The patch addresses the general case of any change to an active window,
> > but not atomically. The code is slightly refactored so io and mem
> > can share more of the window logic.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> Applied with Jason C's ack to pci/host-mvebu for v4.11, thanks!

Thank you for keeping on top of this Bjorn!

Jason
