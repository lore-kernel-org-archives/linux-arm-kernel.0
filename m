From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 13:07:23 -0600
Subject: [PATCH v3 08/12] arm64: dts: tegra: Add Tegra186 support
In-Reply-To: <20160819173233.13260-9-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-9-thierry.reding@gmail.com>
Message-ID: <7c96bc7a-e56e-c8b6-2d89-114eff4eb586@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Joseph Lo <josephl@nvidia.com>
>
> This adds the initial support of Tegra186 SoC. It provides enough to
> enable the serial console and boot from an initial ramdisk.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi

> +	bpmp: bpmp {
> +		compatible = "nvidia,tegra186-bpmp";
> +		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
> +				    TEGRA_HSP_DB_MASTER_BPMP>;
> +		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +
> +		bpmp_i2c: i2c {
> +			compatible = "nvidia,tegra186-bpmp-i2c";
> +			nvidia,bpmp = <&bpmp>;
> +			nvidia,bpmp-bus-id = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +	};

Back on 7/20, Rob Herring wrote:

> Just 'i2c' here. With that:
>
> Acked-by: Rob Herring <robh@kernel.org>

... but this series doesn't yet include the BPMP I2C bindings (they've 
been ack'd so I assume they'll be applied right after this series is). 
Is it better to leave out the I2C sub-node until after the bindings are 
applied, or doesn't the order matter too?
