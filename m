From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Sep 2014 11:11:16 +0100
Subject: [PATCH v2 4/8] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1411325151-15107-3-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-3-git-send-email-linux@rempel-privat.de>
Message-ID: <20140924101116.GA5729@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		osc24m: oscillator {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-accuracy = <30000>;
> +		};
> +
> +		i2s0_mclk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-accuracy = <30000>;
> +		};
> +
> +		i2s1_mclk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-accuracy = <30000>;
> +		};
> +	};

Please just get rid of the clocks node and put these clocks either under
the soc node (if they are part of the SoC) or directly under the root
node.

There is nothing special about a clocks node and its arguably an abuse
of Linux implementaiton details w.r.t. clock probing. The
#address-cells and #size-cells are meaningless (as no children have reg
entries, there's no ranges, and this isn't a simple-bus).

Mark.
