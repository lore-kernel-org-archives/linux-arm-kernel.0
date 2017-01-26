From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Jan 2017 18:03:30 +0100
Subject: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to
 UNMANAGED domains
In-Reply-To: <1484849955-1871-2-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-2-git-send-email-will.deacon@arm.com>
Message-ID: <20170126170329.GB27598@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 06:19:11PM +0000, Will Deacon wrote:
> The ARM SMMU drivers provide a DOMAIN_ATTR_NESTING domain attribute,
> which allows callers of the IOMMU API to request that the page table
> for a domain is installed at stage-2, if supported by the hardware.
> 
> Since setting this attribute only makes sense for UNMANAGED domains,
> this patch returns -ENODEV if the domain_{get,set}_attr operations are
> called on other domain types.

Isn't -EINVAL more suitable here? In the end the domain passed in is
invalid because it does not support attributes, no?



	Joerg
