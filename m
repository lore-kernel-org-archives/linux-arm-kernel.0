From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Feb 2014 17:02:51 +0000
Subject: [PATCHv2 3/8] ARM: at91: dt: sam9rl: Device Tree for the
 at91sam9rlek
In-Reply-To: <1392823951-26053-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1392823951-26053-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140219170251.GB25079@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:32:26PM +0000, Alexandre Belloni wrote:
> Add a device tree for the at91sam9rl-ek. For now it supports:
>  - MMC
>  - dbgu
>  - usart1
>  - watchdog
>  - nand
>  - leds
>  - buttons
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile         |   2 +
>  arch/arm/boot/dts/at91sam9rlek.dts | 151 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91sam9rlek.dts

[...]

> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <12000000>;
> +		};
> +	};

This has no reg. It shouldn't need the unit-address.

Thanks,
Mark.
