From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 6 Jan 2017 12:01:31 +0100
Subject: [PATCH v6 08/18] iommu/vt-d: Implement reserved region get/put
 callbacks
In-Reply-To: <1483643086-2883-9-git-send-email-eric.auger@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-9-git-send-email-eric.auger@redhat.com>
Message-ID: <20170106110131.GM17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 07:04:36PM +0000, Eric Auger wrote:
> +static void intel_iommu_get_resv_regions(struct device *device,
> +					 struct list_head *head)
> +{
> +	struct iommu_resv_region *reg;
> +
> +	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> +				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> +				      0, IOMMU_RESV_NOMAP);
> +	if (!reg)
> +		return;
> +	list_add_tail(&reg->list, head);
> +}

That is different from what AMD does, can you also report the RMRR
regions for the device here (as direct-map regions)?



	Joerg
