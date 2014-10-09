From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Oct 2014 11:03:48 +0100
Subject: [PATCH 1/3] ARM: mediatek: Add basic support for mt6592
In-Reply-To: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <20141009100348.GE3869@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		system_clk: dummy13m {
> +			compatible = "fixed-clock";
> +			clock-frequency = <13000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		rtc_clk: dummy32k {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		uart_clk: uart_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <26000000>;
> +			#clock-cells = <0>;
> +		};
> +	};

There is no need for a clocks node. Please just put these directly under
the root node.

Mark.
