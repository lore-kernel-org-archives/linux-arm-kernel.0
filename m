From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 12:41:55 -0600
Subject: [PATCH v7 4/5] ARM: tegra: Add efuse and apbmisc bindings
In-Reply-To: <1401973754-19701-5-git-send-email-pdeschrijver@nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5390B9F3.8030108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 07:09 AM, Peter De Schrijver wrote:
> Add efuse and apbmisc bindings for Tegra20, Tegra30, Tegra114 and Tegra124.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	apbmisc at 70000800 {
> +		compatible = "nvidia,tegra114-apbmisc", "nvidia,tegra20-apbmisc";

Is the Tegra114 APBMISC register layout 100% a backwards-compatible
superset of that in Tegra20? For both registers the code currently uses
*and* all possible registers the code could ever use? Since the APB MISC
is a bit of a dumping ground for random registers, that feels unlikely,
but perhaps it's possible.
