From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Mar 2014 10:33:54 +0000
Subject: arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <1395048095-32745-1-git-send-email-vkale@apm.com>
References: <1395048095-32745-1-git-send-email-vkale@apm.com>
Message-ID: <20140317103353.GD8070@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 09:21:35AM +0000, Vinayak Kale wrote:
> This patch adds the PMU device tree node for APM X-Gene Storm SOC.
> 
> Please note that this patch has dependancy on a GIC driver patch [1] which is
> yet to be approved by maintainers.
> 
> [1]- https://lkml.org/lkml/2014/2/27/605 
> (irqchip:gic: change access of gicc_ctrl register to read modify write)
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/boot/dts/apm-storm.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index d37d736..587348d 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -97,6 +97,11 @@
>  		clock-frequency = <50000000>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <1 12 0xff04>;
> +	};

Do Potenza CPUs only have the PMUv3 events, and nothing
Potenza-specific?

I would have expected something like:

compatible = "apm,potenza-pmu", "arm,armv8-pmuv3";

Cheers,
Mark.
