From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jul 2017 10:19:10 +0100
Subject: [PATCH v2 1/2] vfio: Allow No-IOMMU mode without checking
 iommu_present()
In-Reply-To: <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
References: <1500525154-5200-1-git-send-email-anup.patel@broadcom.com>
 <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170720091909.GC17837@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 10:02:33AM +0530, Anup Patel wrote:
> Not allowing No-IOMMU mode for devices already having
> iommu_ops on their bus is very conservative.
> 
> We now have IOMMU (such as ARM SMMU) which can bypass
> transcations when IOMMU is not configured for a given
> device. In addition, it is not necessary to have all
> devices on bus to be upstream to an IOMMU on that bus.

How does the SMMU know to bypass in these cases? As I explained before, the
driver-specific command line option is the wrong way to go about arranging
this.

Will
