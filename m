From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2016 17:23:29 +0100
Subject: [PATCH 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1471335734-26893-2-git-send-email-jun.nie@linaro.org>
References: <1471335734-26893-1-git-send-email-jun.nie@linaro.org>
 <1471335734-26893-2-git-send-email-jun.nie@linaro.org>
Message-ID: <20160815162328.GA31080@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 16, 2016 at 04:22:13PM +0800, Jun Nie wrote:
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53","arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53","arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53","arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53","arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};

> +		pmu {
> +			compatible = "arm,armv8-pmuv3";
> +			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		};

Please use "arm,cortex-a53-pmu" for the PMU compatible string.

> +
> +		psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +			cpu_suspend = <0xC4000001>;
> +			cpu_off = <0x84000002>;
> +			cpu_on = <0xC4000003>;
> +			migrate = <0xC4000005>;
> +		};

Given you are PSCI 1.0 compliant, you don't need the function ID properties
here. Please remove them.

Otherwise this generally looks fine.

Thanks,
Mark.
