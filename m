From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Jan 2017 07:51:10 -0800
Subject: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
In-Reply-To: <587C61B3.3070107@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
 <20170113180602.GA30346@infradead.org> <587C61B3.3070107@ti.com>
Message-ID: <20170116155110.GA13495@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 11:31:23AM +0530, Kishon Vijay Abraham I wrote:
> Actually not all devices have hardcoded headers. E.g the platform I'm using
> doesn't have hardcoded headers and it can be configured based on the function
> the user would like to use. If the devices are hardcoded, then using configfs
> can be skipped altogether. In such cases, APIs like pci_epf_create() can
> directly be used by the drivers instead of going via configfs.

That's exactly what I meant - the IDs need to be set by the driver for
the implemented PCI device, and it's not up to the gadget core to configur
e them, it's up to the implementation of the PCIe device which PCI it
exposes.
