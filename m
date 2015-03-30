From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Mar 2015 18:43:15 +0100
Subject: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Message-ID: <20150330174315.GD15655@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Thu, Mar 26, 2015 at 12:43:03PM +0000, Joerg Roedel wrote:
> Changes v1-v2:
> 
> 	* Rebased to v4.0-rc5
> 	* Converted domain-types to a bit-field
> 
> Hi,
> 
> here is patch-set to replace the existing domain_init and
> domain_destroy iommu-ops with the new domain_alloc and
> domain_free callbacks

Whilst I'm still a bit worried about the ability of the IOMMU driver to do
very much in the ->domain_alloc callback (since we don't know which IOMMU
instance the domain is for), it doesn't leave us any worse off than we
currently are.

So, for the arm-smmu patch and the core IOMMU changes:

  Acked-by: Will Deacon <will.deacon@arm.com>

Hopefully this doesn't conflict too badly with my outstanding arm-smmu
pull requests to you, but do shout if you have any trouble.

Will
