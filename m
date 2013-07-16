From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:10:32 -0600
Subject: [PATCH v2 04/22] ARM: dt: tegra30: iommu: Add "nvidia,swgroup"
In-Reply-To: <1373021097-32420-5-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-5-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E5D2E8.5060200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> This is a bitmap that indicates which HardWare Accelerators(HWA) are
> supported on Tegra30 SoC.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> +		nvidia,swgroup = TEGRA30_SWGROUP_ALL;

That property isn't in the binding document. We can't add properties
that aren't documented.

Macros should not include structural syntax; the < > around the cell
value is part of the macro the way you've written it, but shouldn't be.
It'd be simpler to just write:

	nvidia,swgroup = <0x00000000 0x000779ff>;

We should only extend the binding in a backwards-compatible fashion, so
we can't require that DTs contain this value. At least, there should be
a default value defined for when the property doesn't exist.
