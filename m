From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 25 May 2016 10:11:51 +0800
Subject: [PATCH] arm64: tegra: Fix CPU compatible string for Tegra132
In-Reply-To: <20160523074221.7135-1-josephl@nvidia.com>
References: <20160523074221.7135-1-josephl@nvidia.com>
Message-ID: <574509E7.4030208@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2016 03:42 PM, Joseph Lo wrote:
> As per commit f634da375fc96 ("Documentation: DT bindings: add nvidia,
> tegra132-denver compatible string"), fixing the CPU compatible string for
> Tegra132 to match the binding document currently.
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra132.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> index 2013f8916084..7b1cdc029de3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> @@ -964,13 +964,13 @@
>
>   		cpu at 0 {
>   			device_type = "cpu";
> -			compatible = "nvidia,denver", "arm,armv8";
> +			compatible = "nvidia,tegra132-denver", "arm,armv8";

Hi Stephen, Thierry,

Should we fix this or fix the compatible string in the binding document 
as just "nvidia,denver" to represent all the Devner CPU revisions just 
like some other CPUs did? e.g. arm,cortex-a57, which represents all the 
A57 revisions.

Thanks,
-Joseph

>   			reg = <0>;
>   		};
>
>   		cpu at 1 {
>   			device_type = "cpu";
> -			compatible = "nvidia,denver", "arm,armv8";
> +			compatible = "nvidia,tegra132-denver", "arm,armv8";
>   			reg = <1>;
>   		};
>   	};
>
