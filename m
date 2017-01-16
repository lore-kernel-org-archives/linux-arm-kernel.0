From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 11:31:23 +0530
Subject: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
In-Reply-To: <20170113180602.GA30346@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
 <20170113180602.GA30346@infradead.org>
Message-ID: <587C61B3.3070107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Friday 13 January 2017 11:36 PM, Christoph Hellwig wrote:
> Hi Kishon,
> 
> a couple comments on the configfs layout based on my experiments with
> your previous drop to implement a NVMe device using it.

Thanks for trying it out!
> 
> I don't think most of these configfs files should be present here, as
> they are properties of the implemented PCIe devices.  E.g. for my
> NVMe device they will be sort of hardcoded most of the time, as they
> would be for other devices that would always have a fixed vendor/device/
> class ID, cacheline size, etc.

Actually not all devices have hardcoded headers. E.g the platform I'm using
doesn't have hardcoded headers and it can be configured based on the function
the user would like to use. If the devices are hardcoded, then using configfs
can be skipped altogether. In such cases, APIs like pci_epf_create() can
directly be used by the drivers instead of going via configfs.

Thanks
Kishon
