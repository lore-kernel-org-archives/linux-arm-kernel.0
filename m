From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Feb 2015 12:47:58 +0100
Subject: [PATCH 12/14] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1423763164-5606-13-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-13-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1423828078.4182.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Donnerstag, den 12.02.2015, 18:46 +0100 schrieb Maxime Coquelin:
[...]
> +	soc {
> +		reset_ahb1: reset at 40023810 {
> +			#reset-cells = <1>;
> +			compatible = "st,stm32-reset";
> +			reg = <0x40023810 0x4>;
> +		};
> +
> +		reset_ahb2: reset at 40023814 {
> +			#reset-cells = <1>;
> +			compatible = "st,stm32-reset";
> +			reg = <0x40023814 0x4>;
> +		};
> +
> +		reset_ahb3: reset at 40023818 {
> +			#reset-cells = <1>;
> +			compatible = "st,stm32-reset";
> +			reg = <0x40023818 0x4>;
> +		};
> +
> +		reset_apb1: reset at 40023820 {
> +			#reset-cells = <1>;
> +			compatible = "st,stm32-reset";
> +			reg = <0x40023820 0x4>;
> +		};
> +
> +		reset_apb2: reset at 40023824 {
> +			#reset-cells = <1>;
> +			compatible = "st,stm32-reset";
> +			reg = <0x40023824 0x4>;
> +		};

These are mostly consecutive, single registers. I wonder if these are
part of the same IP block and thus should be grouped together into the
same reset controller node?

regards
Philipp
