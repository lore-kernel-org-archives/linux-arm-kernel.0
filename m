From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Thu, 26 Jun 2014 18:41:07 +0000
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <748dccbbd3284521af4659ccbbb11453@BY2PR07MB203.namprd07.prod.outlook.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
 <20140608103129.GC3279@lvm> <20140616145344.GD18986@8bytes.org>
 <20140616151329.GQ16758@arm.com> <20140616152157.GB31771@8bytes.org>
 <20140616152526.GR16758@arm.com> <20140616153832.GC31771@8bytes.org>
 <9353770066894e85809e1e443b71d1cd@BY2PR07MB203.namprd07.prod.outlook.com>
 <748dccbbd3284521af4659ccbbb11453@BY2PR07MB203.namprd07.prod.outlook.com>
Message-ID: <b085e02e72dc424d9624c3e810951087@BY2PR07MB203.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry there was a type,

The question is:
 
            How is VFIO restricting software from writing to MSI/MSI-X vectors of the device. 

-----Original Message-----
From: Chalamarla, Tirumalesh 
Sent: Thursday, June 26, 2014 11:16 AM
To: Chalamarla, Tirumalesh; Joerg Roedel; Will Deacon
Cc: kvm at vger.kernel.org; open list; alex.williamson at redhat.com; stuart.yoder at freescale.com; iommu at lists.linux-foundation.org; tech at virtualopensystems.com; kvmarm at lists.cs.columbia.edu; moderated list:ARM SMMU DRIVER
Subject: RE: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP

When I say emulating ITS, I mean translating guest ITS commands to physical ITS commands  and placing them in physical queue. 

Regards,
Tirumalesh.

-----Original Message-----
From: kvmarm-bounces@lists.cs.columbia.edu [mailto:kvmarm-bounces at lists.cs.columbia.edu] On Behalf Of Chalamarla, Tirumalesh
Sent: Thursday, June 26, 2014 11:08 AM
To: Joerg Roedel; Will Deacon
Cc: kvm at vger.kernel.org; open list; alex.williamson at redhat.com; stuart.yoder at freescale.com; iommu at lists.linux-foundation.org; tech at virtualopensystems.com; kvmarm at lists.cs.columbia.edu; moderated list:ARM SMMU DRIVER
Subject: RE: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP

Forgive me if this discussion is not relative here, but I thought it is.  

How is VFIO restricting devices from writing  to MSI/MSI-X, Is all the vector area is mapped by VFIO to trap the accesses.  I am asking this because we might need to emulate ITS somewhere either in KVM or VFIO to provide direct access to devices.
And I don't see any mentions on that.   I think this flag needs to be set by ITS emulation.

Regards,
Tirumalesh.

-----Original Message-----
From: kvmarm-bounces@lists.cs.columbia.edu [mailto:kvmarm-bounces at lists.cs.columbia.edu] On Behalf Of Joerg Roedel
Sent: Monday, June 16, 2014 8:39 AM
To: Will Deacon
Cc: stuart.yoder at freescale.com; kvm at vger.kernel.org; open list; iommu at lists.linux-foundation.org; alex.williamson at redhat.com; moderated list:ARM SMMU DRIVER; tech at virtualopensystems.com; kvmarm at lists.cs.columbia.edu; Christoffer Dall
Subject: Re: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP

On Mon, Jun 16, 2014 at 04:25:26PM +0100, Will Deacon wrote:
> Ok, thanks. In which case, I think this is really a combined property 
> of the SMMU and the interrupt controller, so we might need some extra 
> code so that the SMMU can check that the interrupt controller for the 
> device is also capable of interrupt remapping.

Right, that this is part of IOMMU code has more or less historic reasons on x86. Interrupt remapping is purely implemented in the IOMMU there, so on ARM some clue-code between interrupt controler and smmu is needed.


	Joerg


_______________________________________________
kvmarm mailing list
kvmarm at lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm at lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
