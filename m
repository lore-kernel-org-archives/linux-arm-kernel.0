From: rjui@broadcom.com (Ray Jui)
Date: Thu, 12 Mar 2015 17:17:36 -0700
Subject: [PATCH v6 3/4] pci: iproc: Add Broadcom iProc PCIe support
In-Reply-To: <20150312210856.GF7346@google.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
 <1426097169-20805-4-git-send-email-rjui@broadcom.com>
 <20150312210856.GF7346@google.com>
Message-ID: <55022CA0.6080806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/12/2015 2:08 PM, Bjorn Helgaas wrote:
> On Wed, Mar 11, 2015 at 11:06:08AM -0700, Ray Jui wrote:
>> This adds the support for Broadcom iProc PCIe controller
>>
>> pcie-iproc.c servers as the common core driver, and front-end bus
>> interface needs to be added to support different bus interfaces
>>
>> pcie-iproc-pltfm.c contains the support for the platform bus interface
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ...
> 
>> +static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> +{
>> +	u8 hdr_type;
>> +	u32 link_ctrl;
>> +	u16 pos, link_status;
>> +	int link_is_active = 0;
>> +
>> +	/* make sure we are not in EP mode */
>> +	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
>> +	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
>> +		dev_err(pcie->dev, "in EP mode, hdr=0x08%x\n", hdr_type);
> 
> "0x08%x" doesn't look right.  I changed it to "%#02x"; is that what you
> intended?
> 
You are right. Will fix it along with the Kconfig fix (so it won't get
compiled for non-ARM platforms). I'll submit v7?

Thanks,

Ray
