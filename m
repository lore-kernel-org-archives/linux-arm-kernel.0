From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Mar 2015 15:03:22 +0100
Subject: [PATCH v2] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <cd616fa25dafee38f98e3b207e74450c5403f440.1425563597.git.michal.simek@xilinx.com>
References: <cd616fa25dafee38f98e3b207e74450c5403f440.1425563597.git.michal.simek@xilinx.com>
Message-ID: <20150305150322.19e378d9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michal Simek,

On Thu,  5 Mar 2015 14:53:34 +0100, Michal Simek wrote:

> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 143 4>,
> +			     <0 144 4>,
> +			     <0 145 4>,
> +			     <0 146 4>;

Any reason not to use

#include <dt-bindings/interrupt-controller/arm-gic.h>
#include <dt-bindings/interrupt-controller/irq.h>

in order to write the more descriptive:

		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;

And ditto for all other interrupts properties?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
