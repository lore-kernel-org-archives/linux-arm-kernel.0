From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 15:52:00 +0100
Subject: Summary of LPC guest MSI discussion in Santa Fe
In-Reply-To: <83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
References: <20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
 <20161109192303.GD15676@cbox> <20161109203145.GO17771@arm.com>
 <20161109151709.74927f83@t450s.home>
 <20161109222522.GS17771@arm.com>
 <20161109162458.39594fdb@t450s.home>
 <20161109233847.GT17771@arm.com>
 <20161109165957.62c1eb61@t450s.home>
 <83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
Message-ID: <20161110145200.GD2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 01:14:42AM +0100, Auger Eric wrote:
> Besides above problematic, I started to prototype the sysfs API. A first
> issue I face is the reserved regions become global to the iommu instead
> of characterizing the iommu_domain, ie. the "reserved_regions" attribute
> file sits below an iommu instance (~
> /sys/class/iommu/dmar0/intel-iommu/reserved_regions ||
> /sys/class/iommu/arm-smmu0/arm-smmu/reserved_regions).
> 
> MSI reserved window can be considered global to the IOMMU. However PCIe
> host bridge P2P regions rather are per iommu-domain.
> 
> Do you confirm the attribute file should contain both global reserved
> regions and all per iommu_domain reserved regions?
> 
> Thoughts?

This information is best attached to the sysfs-representation of
iommu-groups. The file should then contain the superset of all reserved
regions of the devices the group contains. This makes it usable later to
also describe RMRR/Unity-mapped regions on x86 there and make them
assignable to guests as well.


	Joerg
