From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 16 Jun 2014 17:38:32 +0200
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <20140616152526.GR16758@arm.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
 <20140608103129.GC3279@lvm> <20140616145344.GD18986@8bytes.org>
 <20140616151329.GQ16758@arm.com>
 <20140616152157.GB31771@8bytes.org>
 <20140616152526.GR16758@arm.com>
Message-ID: <20140616153832.GC31771@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 04:25:26PM +0100, Will Deacon wrote:
> Ok, thanks. In which case, I think this is really a combined property of
> the SMMU and the interrupt controller, so we might need some extra code
> so that the SMMU can check that the interrupt controller for the device
> is also capable of interrupt remapping.

Right, that this is part of IOMMU code has more or less historic reasons
on x86. Interrupt remapping is purely implemented in the IOMMU there, so
on ARM some clue-code between interrupt controler and smmu is needed.


	Joerg
