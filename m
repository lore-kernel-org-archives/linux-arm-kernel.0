From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 11 Oct 2017 13:32:01 -0500
Subject: [PATCH v4 0/3] Workaround for bus/slot reset on Cavium cn8xxx
 root ports
In-Reply-To: <20170908081033.3025-1-jglauber@cavium.com>
References: <20170908081033.3025-1-jglauber@cavium.com>
Message-ID: <20171011183201.GK25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 10:10:30AM +0200, Jan Glauber wrote:
> Using vfio-pci on a combination of cn8xxx and some PCI devices results in
> a kernel panic. This is triggered by issuing a bus or a slot reset
> on the PCI device.
> 
> With this series both checks indicate that the reset is not possible
> preventing the kernel panic.
> 
> David Daney (2):
>   PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
>   PCI: Avoid bus reset for Cavium cn8xxx root ports
> 
> Jan Glauber (1):
>   PCI: Avoid slot reset if bus reset is not possible
> 
>  drivers/pci/pci.c    | 8 ++++++++
>  drivers/pci/quirks.c | 8 ++++++++
>  2 files changed, 16 insertions(+)

Applied to pci/host-thunder for v4.15, thanks.

I reordered and renamed them like this:

  PCI: Mark Cavium CN8xxx to avoid bus reset
  PCI: Avoid bus reset if bridge itself is broken
  PCI: Avoid slot reset if bridge itself is broken
