From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 6 Jan 2017 12:00:39 +0100
Subject: [PATCH v6 07/18] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <1483643086-2883-8-git-send-email-eric.auger@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-8-git-send-email-eric.auger@redhat.com>
Message-ID: <20170106110039.GL17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 07:04:35PM +0000, Eric Auger wrote:
> +	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
> +		str += sprintf(str, "0x%016llx 0x%016llx\n",
> +			       (long long int)region->start,
> +			       (long long int)(region->start +
> +						region->length - 1));
> +		kfree(region);
> +	}

I think it also makes sense to report the type of the reserved region.



	Joerg
