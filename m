From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Mar 2015 12:24:59 +0000
Subject: [PATCH v5 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
References: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
 <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20150305122459.GC14093@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 05:38:23AM +0000, Chanwoo Choi wrote:
> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> PSCI (Power State Coordination Interface) v0.1.
> 
> This patch includes following dt node to support Exynos5433 SoC:
> 1. Octa core for big.LITTLE architecture
> - Cortex-A53 LITTLE Quad-core
> - Cortex-A57 big Quad-core
> - Support PSCI v0.1

[...]

> +       psci {
> +               compatible = "arm,psci";
> +               method = "smc";
> +               cpu_off = <0x84000002>;
> +               cpu_on = <0xC4000003>;
> +       };

Back at v2 you mentioned that CPU_OFF wasn't working [1].

Do both CPU_ON and CPU_OFF work for all CPUs, including the boot CPU?

I take it CPUs boot at EL2?

[...]

> +               timer {
> +                       compatible = "arm,armv8-timer";
> +                       interrupts = <1 13 0xff04>,
> +                                    <1 14 0xff04>,
> +                                    <1 11 0xff04>,
> +                                    <1 10 0xff04>;
> +               };

The timer node should be moved under the root node. It doesn't live on
the bus; it's a component of the CPU.

Thanks,
Mark.

[1] https://lkml.org/lkml/2014/12/2/413
