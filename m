From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Apr 2012 13:34:50 -0600
Subject: [PATCH 3/3] arm/dts: Tegra30: Add device tree support for SMMU
In-Reply-To: <1335182340-17237-3-git-send-email-hdoyu@nvidia.com>
References: <1335182340-17237-1-git-send-email-hdoyu@nvidia.com>
 <1335182340-17237-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <4F97005A.2010305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 05:58 AM, Hiroshi DOYU wrote:
> Add device tree support for Tegra30 IOMMU(SMMU).

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> +	smmu: smmu at 7000f000 {
...
> +		interrupts = <0 13 0x40>;

This interrupt is on the 3rd IRQ controller (or GIC bank) so should be
(2*32)+13, i.e. 75 not 13.
