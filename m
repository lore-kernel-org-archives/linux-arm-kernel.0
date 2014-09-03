From: nm@ti.com (Nishanth Menon)
Date: Wed, 3 Sep 2014 08:39:08 -0500
Subject: [PATCH] ARM: dts: DRA7: Add PMU nodes
In-Reply-To: <1408456440-30171-1-git-send-email-nm@ti.com>
References: <1408456440-30171-1-git-send-email-nm@ti.com>
Message-ID: <540719FC.5070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2014 08:54 AM, Nishanth Menon wrote:
> From: Lucas Weaver <l-weaver@ti.com>
> 
> DRA74x and DRA72x family of processors vary slightly in the number
> of CPUs. So, add different instances of PMU for each of these processor
> groups. Further, since the interrupts bypass crossbar and are directly
> connected to GIC, mark the dts nodes with relevant information.
> 
> Tested with perf utility.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lucas Weaver <l-weaver@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
Hi,
Gentle ping..

Regards,
Nishanth Menon
>  arch/arm/boot/dts/dra72x.dtsi |    5 +++++
>  arch/arm/boot/dts/dra74x.dtsi |    6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> index f1ec22f..e5a3d23 100644
> --- a/arch/arm/boot/dts/dra72x.dtsi
> +++ b/arch/arm/boot/dts/dra72x.dtsi
> @@ -22,4 +22,9 @@
>  			reg = <0>;
>  		};
>  	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
> index a4e8bb9..3be544c 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -38,4 +38,10 @@
>  			reg = <1>;
>  		};
>  	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
> +	};
>  };
> 


-- 
Regards,
Nishanth Menon
