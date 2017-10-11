From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 11 Oct 2017 17:33:02 +0200
Subject: [PATCH v4 0/3] Workaround for bus/slot reset on Cavium cn8xxx
 root ports
In-Reply-To: <20170908081033.3025-1-jglauber@cavium.com>
References: <20170908081033.3025-1-jglauber@cavium.com>
Message-ID: <20171011153302.GN17961@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On 08.09.17 10:10:30, Jan Glauber wrote:
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

if you don't have any objections, please apply this series.

Thanks,

-Robert
