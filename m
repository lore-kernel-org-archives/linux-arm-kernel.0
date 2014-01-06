From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 06 Jan 2014 13:40:51 -0700
Subject: [PATCH v2 3/6] ARM: tegra: Add efuse bindings
In-Reply-To: <1387891931-9854-4-git-send-email-pdeschrijver@nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52CB14D3.2060904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> Add efuse bindings for Tegra20, Tegra30, Tegra114 and Tegra124.

This patch doesn't add bindings, it adds nodes to device trees. Bindings
are the schemas that dictate how the nodes are to be constructed, not
the nodes themselves.

On that topic, this series needs to create
Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt etc.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	efuse at 7000f800 {
...
> +	};
> +
>  	cpus {

This node isn't sorted correctly. It should be between sdhci at 700b0600
and ahub at 70300000, not after the ahub.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	efuse at 7000F800 {

"fuse" might be a better node name; "efuse" is presumably the name of
the instance, not the type of object.

Please use lower-case for hex constants; both here and in the reg property.
