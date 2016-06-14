From: Wei.Chen@arm.com (Wei Chen)
Date: Tue, 14 Jun 2016 10:00:21 +0000
Subject: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
In-Reply-To: <20160614085627.GA19407@arm.com>
References: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com>
 <20160613124531.GE1605@arm.com>
 <CANta1d-wRGcU51P3Av7EXbvu7hJfUBk_Kd5p=7RDMW6u+v0gvg@mail.gmail.com>
 <20160614085627.GA19407@arm.com>
Message-ID: <DB5PR0801MB151054CCAD2ABFC0F2BB85B19E540@DB5PR0801MB1510.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: 2016?6?14? 16:56
> To: Wei Chen
> Cc: Wei Chen; Steve Capper; joro at 8bytes.org; linux-kernel at vger.kernel.org;
> iommu at lists.linux-foundation.org; Robin Murphy; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
>
> On Tue, Jun 14, 2016 at 11:11:36AM +0800, Wei Chen wrote:
> > On 13 June 2016 at 20:45, Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Jun 13, 2016 at 05:20:17PM +0800, Wei Chen wrote:
> > >> The PCIe ACS capability will affect the layout of iommu groups.
> > >> Generally speaking, if the path from root port to the PCIe device
> > >> is ACS enabled, the iommu will create a single iommu group for this
> > >> PCIe device. If all PCIe devices on the path are ACS enabled then
> > >> Linux can determine this path is ACS enabled.
> > >>
> > >> Linux use two PCIe configuration registers to determine the ACS
> > >> status of PCIe devices:
> > >> ACS Capability Register and ACS Control Register.
> > >>
> > >> The first register is used to check the implementation of ACS
> > >> function of a PCIe device, the second register is used to check the
> > >> enable status of ACS function. If one PCIe device has implemented
> > >> and enabled the ACS function then Linux will determine this PCIe
> device enabled ACS.
> > >>
> > >> From the Chapter:6.12 of PCI Express Base Specification Revision
> > >> 3.1a, we can find that when a PCIe device implements ACS function,
> > >> the enable status is set to disabled by default and can be enabled
> > >> by ACS-aware software.
> > >>
> > >> ACS will affect the iommu groups topology, so, the iommu driver is
> > >> ACS-aware software. This patch adds a call to pci_request_acs() to
> > >> the arm-smmu driver to enable the ACS function in PCIe devices that
> > >> support it.
> > >>
> > >> Signed-off-by: Wei Chen <Wei.Chen@arm.com>
> > >> ---
> > >>  drivers/iommu/arm-smmu-v3.c | 2 ++
> > >>  drivers/iommu/arm-smmu.c    | 4 +++-
> > >>  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > Thanks, queued for 4.8 w/ Robin and Eric's reviewed-by tags and the
> > > minor commit wording change.
> > >
> >
> > Thanks, I will post a v2 patch to include above changes.
>
> :/ As above, I've already queued this.
Oh, thank you :)
>
> Will

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
