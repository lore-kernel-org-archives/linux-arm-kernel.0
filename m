From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 14:45:48 +0200
Subject: [PATCH] ARM64: dts: marvell: armada37xx: Fix timer interrupt
 specifiers
In-Reply-To: <20170621214508.7810-1-marc.zyngier@arm.com> (Marc Zyngier's
 message of "Wed, 21 Jun 2017 22:45:08 +0100")
References: <20170621214508.7810-1-marc.zyngier@arm.com>
Message-ID: <871sqazxc3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
 
 On mer., juin 21 2017, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Contrary to popular belief, PPIs connected to a GICv3 to not have
> an affinity field similar to that of GICv2. That is consistent
> with the fact that GICv3 is designed to accomodate thousands of
> CPUs, and fitting them as a bitmap in a byte is... difficult.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 4d495ec39202..bc179efb10ef 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -75,14 +75,10 @@
>  
>  	timer {
>  		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13
> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 14
> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 11
> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 10
> -			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	soc {
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
