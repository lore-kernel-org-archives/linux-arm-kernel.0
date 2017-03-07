From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 7 Mar 2017 10:38:39 +0000
Subject: [PATCH 04/11] arm64: tegra: Enable I2C controllers on P3310
In-Reply-To: <20170223173053.19701-4-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-4-thierry.reding@gmail.com>
Message-ID: <7b24fc3d-6b4f-7f26-4bff-4ffd4f38fb5d@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23/02/17 17:30, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The P3310 processor modules use seven I2C controllers for various
> peripherals.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 40 +++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index 3653d0dd5f4f..762f4756346c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -6,6 +6,14 @@
>  
>  	aliases {
>  		serial0 = &uarta;
> +		i2c0 = "/bpmp/i2c";
> +		i2c1 = "/i2c at 3160000";
> +		i2c2 = "/i2c at c240000";
> +		i2c3 = "/i2c at 3180000";
> +		i2c4 = "/i2c at 3190000";
> +		i2c5 = "/i2c at 31c0000";
> +		i2c6 = "/i2c at c250000";
> +		i2c7 = "/i2c at 31e0000";

Does it matter that these aliases do not align with the TRM numbering? I
know that if we did it would create holes but I was not sure if that
would be clearer?

>  	};
>  
>  	chosen {
> @@ -22,10 +30,38 @@
>  		status = "okay";
>  	};
>  
> +	i2c at 3160000 {
> +		status = "okay";
> +	};
> +
> +	i2c at 3180000 {
> +		status = "okay";
> +	};
> +
> +	i2c at 3190000 {
> +		status = "okay";
> +	};
> +
> +	i2c at 31c0000 {
> +		status = "okay";
> +	};
> +
> +	i2c at 31e0000 {
> +		status = "okay";
> +	};
> +
>  	hsp at 3c00000 {
>  		status = "okay";
>  	};
>  
> +	i2c at c240000 {
> +		status = "okay";
> +	};
> +
> +	i2c at c250000 {
> +		status = "okay";
> +	};
> +
>  	pmc at c360000 {
>  		nvidia,invert-interrupt;
>  	};
> @@ -57,7 +93,9 @@
>  	};
>  
>  	bpmp {
> -		status = "okay";
> +		i2c {
> +			status = "okay";
> +		};
>  	};
>  
>  	psci {
> 

Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
