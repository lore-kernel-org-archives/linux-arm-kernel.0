From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 12:46:06 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87bn01o7jg.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <20160906063529.GA22312@b29397-desktop> <87bn01o7jg.fsf@linux.intel.com>
Message-ID: <4416687.vUjZzKWZG6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 9:40:19 AM CEST Felipe Balbi wrote:
> 
> this only solves the problem for DT devices. Legacy devices and
> PCI-based systems will still suffer from the same problem. At least for
> dwc3, I will only be taking patches that solve the problem for all
> users, not a subset of them.

I don't think legacy devices are a worry, because they wouldn't
have this problem. For the PCI case, you are right that it cannot
work, in particular for machines that have complex IOMMU setup.

Some architectures (at least arm64 and sparc) check the bus_type of
a device in order to find the correct set of dma_map_ops for that
device, so there is no real way to handle this as long as you
pass a platform_device into an API that expects a pci_device.

	Arnd
