From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 20 Sep 2017 12:09:12 -0600
Subject: [v4,0/3] Workaround for bus/slot reset on Cavium cn8xxx root ports
In-Reply-To: <20170912094049.GA14111@localhost.localdomain>
References: <20170908081033.3025-1-jglauber@cavium.com>
 <20170912094049.GA14111@localhost.localdomain>
Message-ID: <20170920120912.7544420d@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Sep 2017 02:40:49 -0700
Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com> wrote:

> Hi all,
> 
> Are there any updates on this ?
> Comments/objections/acks/nacks ?
> 
> WBBR,
> Vadim
> 
> On Fri, Sep 08, 2017 at 10:10:30AM +0200, Jan Glauber wrote:
> > Using vfio-pci on a combination of cn8xxx and some PCI devices results in
> > a kernel panic. This is triggered by issuing a bus or a slot reset
> > on the PCI device.
> > 
> > With this series both checks indicate that the reset is not possible
> > preventing the kernel panic.
> > 
> > David Daney (2):
> >   PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
> >   PCI: Avoid bus reset for Cavium cn8xxx root ports
> > 
> > Jan Glauber (1):
> >   PCI: Avoid slot reset if bus reset is not possible
> > 
> >  drivers/pci/pci.c    | 8 ++++++++
> >  drivers/pci/quirks.c | 8 ++++++++
> >  2 files changed, 16 insertions(+)  


Looks ok to me, for series:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

I am curious why we're happy targeting this quirk at a single device ID
while at the same time trying to expand the ACS quirk to a notable
fraction of the Cavium PCI device ID address space.  Thanks,

Alex
