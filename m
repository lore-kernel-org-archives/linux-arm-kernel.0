From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Aug 2016 19:00:50 +0900
Subject: [PATCH v2 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
References: <1470045256-9032-1-git-send-email-marc.zyngier@arm.com>
 <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAK7LNARVw+mDhHT2+WjDtHpBvsxauUQpRCJeNLrQxrj0Oo=hrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-01 18:54 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> The ARM architected timer specification mandates that the interrupt
> associated with each timer is level triggered (which corresponds to
> the "counter >= comparator" condition).
>
> A number of DTs are being remarkably creative, declaring the interrupt
> to be edge triggered. A quick look at the TRM for the corresponding ARM
> CPUs clearly shows that this is wrong, and I've corrected those.
> For non-ARM designs (and in the absence of a publicly available TRM),
> I've made them active low as well, which can't be completely wrong
> as the GIC cannot disinguish between level low and level high.
>
> The respective maintainers are of course welcome to prove me wrong.
>
> While I was at it, I took the liberty to fix a couple of related issue,
> such as some spurious affinity bits on ThunderX, and their complete
> absence on ls1043a (both of which seem to be related to copy-pasting
> from other DTs).
>
> Acked-by: Duc Dang <dhdang@apm.com>
> Acked-by: Carlo Caione <carlo@endlessm.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
>  arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
>  arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
>  arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 8 ++++----
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
>  arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----


For uniphier-ph1-ld20.dtsi,

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thank you!!


-- 
Best Regards
Masahiro Yamada
