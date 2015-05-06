From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 May 2015 00:17:08 -0700
Subject: [PATCH 1/2] dt-bindings: Add pxa1928 clock binding
In-Reply-To: <1430455271-20195-1-git-send-email-robh@kernel.org>
References: <1430455271-20195-1-git-send-email-robh@kernel.org>
Message-ID: <20150506071708.GD27050@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30, Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt b/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt
> new file mode 100644
> index 0000000..809c5a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt
> @@ -0,0 +1,21 @@
> +* Marvell PXA1928 Clock Controllers
> +
> +The PXA1928 clock subsystem generates and supplies clock to various
> +controllers within the PXA1928 SoC. The PXA1928 contains 3 clock controller
> +blocks called APMU, MPMU, and APBC roughly corresponding to internal buses.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "marvell,pxa1928-apmu" - APMU controller compatible
> +  - "marvell,pxa1928-mpmu" - MPMU controller compatible
> +  - "marvell,pxa1928-apbc" - APBC controller compatible
> +- reg: physical base address of the clock controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +- #reset-cells: should be 1.
> +
> +Each clock is assigned an identifier and client nodes use the clock controller
> +phandle and this identifier to specify the clock which they consume.
> +
> +All these identifiers can be found in <dt-bindings/clock/marvell,pxa1928.h>.

No example?

> diff --git a/include/dt-bindings/clock/marvell,pxa1928.h b/include/dt-bindings/clock/marvell,pxa1928.h
> new file mode 100644
> index 0000000..c393ca2
> --- /dev/null
> +++ b/include/dt-bindings/clock/marvell,pxa1928.h
> @@ -0,0 +1,57 @@
> +#ifndef __DTS_MARVELL_PXA1928_CLOCK_H
> +#define __DTS_MARVELL_PXA1928_CLOCK_H
> +
> +/*
> + * Clock ID values here correspond to the control register offset/4.
> + */
> +
> +/* apb periphrals */

s/periphrals/peripherals/ ?

> +#define PXA1928_CLK_RTC			0
> +#define PXA1928_CLK_TWSI0		1
> +#define PXA1928_CLK_TWSI1		2
> +#define PXA1928_CLK_TWSI2		3
> +#define PXA1928_CLK_TWSI3		4
> +#define PXA1928_CLK_OWIRE		5
> +#define PXA1928_CLK_KPC			6
> +#define PXA1928_CLK_TB_ROTARY		7
> +#define PXA1928_CLK_SW_JTAG		8
> +#define PXA1928_CLK_TIMER1		9

This is really nitpicky, but I find the jump from decimal to hex odd. 
Is there any reason why we don't just use decimal or hex throughout?
Perhaps it's related to why there are holes in the number space?

> +#define PXA1928_CLK_UART0		0xb
> +#define PXA1928_CLK_UART1		0xc
> +#define PXA1928_CLK_UART2		0xd
> +#define PXA1928_CLK_GPIO		0xe
> +#define PXA1928_CLK_PWM0		0xf
> +#define PXA1928_CLK_PWM1		0x10
> +#define PXA1928_CLK_PWM2		0x11
> +#define PXA1928_CLK_PWM3		0x12
> +#define PXA1928_CLK_SSP0		0x13
> +#define PXA1928_CLK_SSP1		0x14
> +#define PXA1928_CLK_SSP2		0x15
> +
> +#define PXA1928_CLK_TWSI4		0x1f
> +#define PXA1928_CLK_TWSI5		0x20
> +#define PXA1928_CLK_UART3		0x22
> +#define PXA1928_CLK_THSENS_GLOB		0x24
> +#define PXA1928_CLK_THSENS_CPU		0x26
> +#define PXA1928_CLK_THSENS_VPU		0x27
> +#define PXA1928_CLK_THSENS_GC		0x28
> +#define PXA1928_APBC_NR_CLKS		0x30
> +
> +
> +/* axi periphrals */

s/periphrals/peripherals/ ?

> +#define PXA1928_CLK_SDH0		0x15
> +#define PXA1928_CLK_SDH1		0x16
> +#define PXA1928_CLK_USB			0x17
> +#define PXA1928_CLK_NAND		0x18
> +#define PXA1928_CLK_DMA			0x19
> +
> +#define PXA1928_CLK_SDH2		0x3a
> +#define PXA1928_CLK_SDH3		0x3b
> +#define PXA1928_CLK_HSIC		0x3e
> +#define PXA1928_CLK_SDH4		0x57
> +#define PXA1928_CLK_GC3D		0x5d
> +#define PXA1928_CLK_GC2D		0x5f
> +
> +#define PXA1928_APMU_NR_CLKS		0x60
> +
> +#endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
