From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 14 Jul 2015 09:19:00 -0500
Subject: [PATCH v3 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <1436851111-2369-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436851111-2369-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <55A51A54.7000208@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2015 12:18 AM, Yingjoe Chen wrote:
> Add arch timer node to enable arch-timer support. MT8135 firmware
> doesn't correctly setup arch-timer frequency and CNTVOFF, add
> properties to workaround this.

[...]

>  
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <13000000>;
> +		arm,cpu-registers-not-fw-configured;

It's disappointing to see this property in new DTS submissions.  It
prevents taking advantage of the VDSO for gettimeofday/clock_gettime.
