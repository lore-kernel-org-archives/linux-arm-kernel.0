From: jingoohan1@gmail.com (Jingoo Han)
Date: Wed, 26 Apr 2017 13:24:48 -0400
Subject: [PATCH v4 00/21] PCI: fix config space memory mappings
In-Reply-To: <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
 <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
Message-ID: <000501d2beb2$023b9100$06b2b300$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 26, 2017 6:54 AM, Dongdong Liu wrote;
> 
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> 
> I tested the patchset on HiSilicon ARM64 D05 board.It works ok with 82599
> netcard.

Thank you for testing these patches. HiSilicon PCIe may use Designware-based
PCIe controller. In my opinion, other Designware-based PCIe controller will
work properly.

To Dongdong Liu, Khuong Dinh, and other people,
If possible, can you check the output of 'lspci -v'?
If you find something different, please share it with us.
Good luck.

Best regards,
Jingoo Han

> 
> Thanks,
> Dongdong
> ? 2017/4/25 14:40, Jon Masters ??:
> > On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:
> >
> >> On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> >> configuration non-posted write transactions requirement, because it
> >> provides a memory mapping that issues "bufferable" or, in PCI terms
> >> "posted" write transactions. Likewise, the current pci_remap_iospace()
> >> implementation maps the physical address range that the PCI translates
> >> to I/O space cycles to virtual address space through pgprot_device()
> >> attributes that on eg ARM64 provides a memory mapping issuing
> >> posted writes transactions, which is not PCI specifications compliant.
> >
> > Side note that I've pinged all of the ARM server vendors and asked them
> > to verify this patch series on their platforms.
> >
> > Jon.
> >
> > .
> >
