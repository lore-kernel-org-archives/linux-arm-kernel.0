From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Aug 2016 17:00:34 +0100
Subject: [PATCH v2 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1472221932-6730-3-git-send-email-jun.nie@linaro.org>
References: <1472221932-6730-1-git-send-email-jun.nie@linaro.org>
 <1472221932-6730-3-git-send-email-jun.nie@linaro.org>
Message-ID: <20160826160034.GA32695@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:32:11PM +0800, Jun Nie wrote:
> Add device tree support for ZX296718 SoC and evaluation board based on it.
> Also document new values.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

NAK.

I did *not* provide a Reviewed-by in v1 [1,2]. Please remove this tag.

Unless explicitly provided, do not add a Reviewed-by tag. Comments alone do not
imply a Reviewed-by tag.

I also have a further comment below.

> +		gic: interrupt-controller at 2a00000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			#redistributor-regions = <6>;
> +			redistributor-stride = <0x0 0x40000>;
> +			interrupt-controller;
> +			reg = <0x02a00000 0x10000>,
> +			      <0x02b00000 0x20000>,
> +			      <0x02b20000 0x20000>,
> +			      <0x02b40000 0x20000>,
> +			      <0x02b60000 0x20000>,
> +			      <0x02b80000 0x20000>,
> +			      <0x02ba0000 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		};

GIC_CPU_MASK* is only valid for GICv2, not GICv3. Please remove the
GIC_CPU_MASK_SIMPLE(8) uses from these.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/449162.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/449230.html
