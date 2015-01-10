From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 10 Jan 2015 09:34:27 -0700
Subject: [PATCH v2] ARM: dts: add bcm2835-pwm bindings
In-Reply-To: <1420628458-11459-1-git-send-email-bart.tanghe@thomasmore.be>
References: <1420628458-11459-1-git-send-email-bart.tanghe@thomasmore.be>
Message-ID: <54B15493.5030406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 04:00 AM, Bart Tanghe wrote:
> To probe the bcm2835-pwm driver properly, this dts bindings has to be added 
> to the bcm2835 dtsi file.
> In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding.

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

> +		pwm: pwm at 7e20e000 {
> +			compatible = "brcm,bcm2835-pwm";
> +			reg = <0x7e20c000 0x28>;
> +			clocks = <&clk_pwm>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};

Can the nodes be kept sorted by reg value; I think this should be added
between the existing i2c at 20205000 and sdhci at 7e300000 nodes.

Aside from that,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
