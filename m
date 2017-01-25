From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 25 Jan 2017 11:10:53 +0530
Subject: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
In-Reply-To: <20170124160224.GA23528@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
 <20170124160224.GA23528@infradead.org>
Message-ID: <58883A65.8020306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 24 January 2017 09:32 PM, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCI endpoint test driver that can verify base address
>> register, legacy interrupt/MSI interrupt and read/write/copy
>> buffers between host and device. The corresponding pci-epf-test
>> function driver should be used on the EP side.
> 
> Just curious:  what would you think of a text based (e.g. debugfs)
> interface to avoid the need for a userspace tool here?

I felt having a userspace tool gives the flexibility to add more tests
(iterations, sizes etc..) while the driver can just focus on performing simple
tests. Say we'd like to perform infinite read/write tests, it's better if the
userspace tool invokes read/write tests repeatedly instead of that being
implemented in the driver.
> 
>> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
> Also this looks really odd, and dangerous.  Probing for any
> TI device will bind to all kinds of legit devices.  It would
> be good if you could squeeze out a single id for this device

There is actually an id for the device, but I think we'll need an id for every
function right?

Having said that the id for the device is better than PCI_ANY_ID. Will fix it
in my next revision.

Thanks
Kishon
