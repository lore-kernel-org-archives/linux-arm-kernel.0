From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jan 2016 13:25:05 +0000
Subject: [PATCH v4 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <1452085914-29340-3-git-send-email-vishnupatekar0510@gmail.com>
References: <1452085914-29340-1-git-send-email-vishnupatekar0510@gmail.com>
 <1452085914-29340-3-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160106132505.GJ563@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +	chosen {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +	};

What is the ranges property doing here?

[...]

> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		osc24M: osc24M_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +			clock-output-names = "osc24M";
> +		};
> +
> +		osc32k: osc32k_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +			clock-output-names = "osc32k";
> +		};
> +	};

Just put the clocks under the root node. 'clocks' is not a special node.

Thanks,
Mark.
