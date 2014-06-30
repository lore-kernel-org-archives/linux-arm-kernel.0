From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 14:45:28 -0600
Subject: [PATCH 3/6] ARM: tegra: Add thermal trip points for Jetson TK1
In-Reply-To: <1403856699-2140-4-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-4-git-send-email-mperttunen@nvidia.com>
Message-ID: <53B1CC68.8070104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds critical trip points to the Jetson TK1 device tree.
> The device will do a controlled shutdown when either the CPU, GPU
> or MEM thermal zone reaches 101 degrees Celsius.

It would be more typical to order the patches with changes to
tegra124.dtsi first, then changes to board files (that build on the core
SoC support) second.

> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts

> +	thermal-zones {
> +		cpu {
> +			trips {
> +				cpu-critical {

Can we name that simply "critical"? DT node names are supposed to
represent type of object more than identity of object. Even "critical"
is a bit of an identity, and "trip at 0" would be better, but I imagine the
core thermal DT bindings precluded that?
