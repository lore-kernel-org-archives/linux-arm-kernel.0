From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Nov 2016 10:37:14 +0000
Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
Message-ID: <20161130103713.GB2724@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 10:49:33AM +0100, Auger Eric wrote:
> On 15/11/2016 14:09, Eric Auger wrote:
> > Following LPC discussions, we now report reserved regions through
> > iommu-group sysfs reserved_regions attribute file.
> > 
> > Reserved regions are populated through the IOMMU get_resv_region callback
> > (former get_dm_regions), now implemented by amd-iommu, intel-iommu and
> > arm-smmu.
> > 
> > The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
> > IOMMU_RESV_NOMAP reserved region.
> > 
> > arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and
> > 1MB large) and the PCI host bridge windows.
> > 
> > The series integrates a not officially posted patch from Robin:
> > "iommu/dma: Allow MSI-only cookies".
> > 
> > This series currently does not address IRQ safety assessment.
> 
> I will respin this series taking into account Joerg's comment. Does
> anyone have additional comments or want to put forward some conceptual
> issues with the current direction and with this implementation?
> 
> As for the IRQ safety assessment, in a first step I would propose to
> remove the IOMMU_CAP_INTR_REMAP from arm-smmus and consider the
> assignment as unsafe. Any objection?

Well, yeah, because it's perfectly safe with GICv3.

Will
