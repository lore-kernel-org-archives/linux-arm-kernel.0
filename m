From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Feb 2018 10:21:41 +0000
Subject: [PATCH v2 6/7] arm64: tegra: Add Tegra194 chip device tree
In-Reply-To: <1517901757-15353-7-git-send-email-mperttunen@nvidia.com>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-7-git-send-email-mperttunen@nvidia.com>
Message-ID: <458ba9f9-d703-9edf-8e7b-bc9d0f0ef0cc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikko,

On 06/02/18 07:22, Mikko Perttunen wrote:
> Add the chip-level device tree, including binding headers, for the
> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
> are initially available, enough to boot to UART console.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 342 +++++++++++++
>  include/dt-bindings/clock/tegra194-clock.h     | 664 +++++++++++++++++++++++++
>  include/dt-bindings/gpio/tegra194-gpio.h       |  59 +++
>  include/dt-bindings/power/tegra194-powergate.h |  49 ++
>  include/dt-bindings/reset/tegra194-reset.h     | 166 +++++++
>  5 files changed, 1280 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> new file mode 100644
> index 000000000000..dda28d758cab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi

[...]

> +		gic: interrupt-controller at 3881000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x03881000 0x1000>,
> +			      <0x03882000 0x2000>;

You're missing the GICH and GICV regions here.

> +			interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			interrupt-parent = <&gic>;
> +		};
Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
