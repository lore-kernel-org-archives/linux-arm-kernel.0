From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Jan 2017 14:34:18 +0000
Subject: [PATCH] PCI: mvebu: Handle changes to the bridge windows while
 enabled
In-Reply-To: <20170128211728.GJ20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20161212183020.GA30274@obsidianresearch.com>
 <20170111183055.GD14532@bhelgaas-glaptop.roam.corp.google.com>
 <20170128211728.GJ20550@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170130143418.GB25924@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Sat, Jan 28, 2017 at 03:17:28PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 11, 2017 at 12:30:55PM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 12, 2016 at 11:30:20AM -0700, Jason Gunthorpe wrote:
> > > The PCI core will write to the bridge window config multiple times
> > > while they are enabled. This can lead to mbus failures like:
> > > 
> > >  mvebu_mbus: cannot add window '4:e8', conflicts with another window
> > >  mvebu-pcie mbus:pex at e0000000: Could not create MBus window at [mem 0xe0000000-0xe00fffff]: -22
> > > 
> > > For me this is happening during a hotplug cycle. The PCI core is
> > > not changing the values, just writing them twice while active.
> > > 
> > > The patch addresses the general case of any change to an active window,
> > > but not atomically. The code is slightly refactored so io and mem
> > > can share more of the window logic.
> > 
> > Looks good to me, but I'm waiting for an ack from Thomas or Jason (listed
> > as maintainers and already cc'd).
> 
> Ping, Thomas, Jason C?
> 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > ---
> > >  drivers/pci/host/pci-mvebu.c | 101 +++++++++++++++++++++++++------------------
> > >  1 file changed, 60 insertions(+), 41 deletions(-)

Sorry, been on travel and I think Thomas is on holiday.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
