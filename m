From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 30 Aug 2017 15:07:00 -0500
Subject: [PATCH 0/2] fix 4GB DRAM window support on mvebu
In-Reply-To: <20170828152517.24506-1-jlu@pengutronix.de>
References: <20170828152517.24506-1-jlu@pengutronix.de>
Message-ID: <20170830200700.GX8154@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 05:25:15PM +0200, Jan Luebbe wrote:
> The current MBUS DRAM window calculation fails for 4GB windows because it
> overflows. This is fixed in the first patch by using u64 instead of u32 to
> store the size. The second excplicitly checks that we don't try to configure a
> too large memory window in the pci driver.
> 
> As they don't depend on each other, they could also go in separatly.
> 
> Jan Luebbe (2):
>   bus: mbus: fix window size calculation for 4GB windows
>   PCI: mvebu: Check DRAM window size
> 
>  drivers/bus/mvebu-mbus.c     |  2 +-
>  drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
>  include/linux/mbus.h         |  4 ++--
>  3 files changed, 25 insertions(+), 8 deletions(-)

Since these can be applied separately, I'll let somebody else take care of
the drivers/bus/mvebu-mbus.c part.

I'll look for an ack from Thomas or Jason before applying the second patch,
which touches drivers/pci/host/pci-mvebu.c.
