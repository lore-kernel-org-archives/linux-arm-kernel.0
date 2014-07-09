From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 14:40:50 +0100
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140709134050.GN9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

  Acked-by: Will Deacon <will.deacon@arm.com>

I would like to move the ARM SMMU driver over to this for 3.18, if possible.
One use-case there is the ability to describe groups of masters behind a
multi-master IOMMU but which must be part of the same domain (i.e. an
iommu_group). This is useful for presenting devices to a guest with a
virtual SMMU, where the physical devices share a stage-2 context.

With your binding, does this simply mean determining the set of master IDs
in the group, then describing the complete set for each master?

Will
