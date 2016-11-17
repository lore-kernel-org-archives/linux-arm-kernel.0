From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Nov 2016 17:21:34 +0000
Subject: [PATCH 8/9] arm64: tegra: Enable PSCI on P3310
In-Reply-To: <20161117171131.20062-8-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
 <20161117171131.20062-8-thierry.reding@gmail.com>
Message-ID: <786f354d-a1f2-f2c6-fde7-7b1af3df756c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/16 17:11, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The P3310 processor module comes ships with a firmware that implements
> PSCI 1.0. Enable and use it to bring up all CPUs.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index 807af7b68761..2c158c6809a5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -26,7 +26,43 @@
>  		status = "okay";
>  	};
>
> +	cpus {
> +		cpu at 0 {
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 4 {
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 5 {
> +			enable-method = "psci";
> +		};
> +	};
> +
>  	bpmp {
>  		status = "okay";
>  	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		status = "okay";
> +		method = "smc";

[...]

> +
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;
> +		cpu_suspend = <0xc4000001>;

These are applicable only for "arm,psci"(i.e. PSCI v0.1), so you need to
drop them.

-- 
Regards,
Sudeep
