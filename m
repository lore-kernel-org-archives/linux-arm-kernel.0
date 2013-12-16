From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 11:46:56 -0700
Subject: [PATCHv7 07/12] iommu/tegra: smmu: register device to iommu
 dynamically
In-Reply-To: <1386835033-4701-8-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-8-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF4AA0.60006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> platform_devices are registered as IOMMU'able dynamically via
> add_device() and remove_device().

That says {add,remove}_device() ...

> Tegra SMMU can have multiple address spaces(AS). IOMMU'able devices
> can belong to one of them. Multiple IOVA maps are created at boot-up,
> which can be attached to devices later. We reserve 2 of them for
> static assignment, AS[0] for system default, AS[1] for AHB clusters as
> protected domain from others, where there are many traditional
> pheripheral devices like USB, SD/MMC. They should be isolated from
> some smart devices like host1x for system robustness. Even if smart
> devices behaves wrongly, the traditional devices(SD/MMC, USB) wouldn't
> be affected, and the system could continue most likely. DMA API(ARM)
> needs ARM_DMA_USE_IOMMU to be enabled.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> v6:
> Use smmu_iommu_{bound,unbind}_driver() instead of
> smmu_iommu_{add,del}_device() to register devices to SMMU.

... yet that says it's been changed to {bound,unbind}_driver(). BTW,
what was the reason for this change?
