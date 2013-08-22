From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 11:07:26 -0700
Subject: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree
In-Reply-To: <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Tue, 20 Aug 2013 10:31:07 +0800")
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <8761uxsiox.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ DT maintainers]

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> Enable Hisilicon Hi4511 development platform with device tree support.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

There seems to be use of several new vendor-specific bindings here that
are not documented anywhere:

hisilicon,sctrl 
hisilicon,pmctrl
hisilicon,clk-mux
hisilicon,clk-div
hisilicon,clk-gate

Not only that, the clock-related compatible properties used here are
different than the ones specificed PATCH 10/11 of this series where you
document some clock bindings.  

also...

[...]

> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0x0>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	osc32k: osc32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc32khz";
> +	};

...seems many of the recent users of clocks have grouped them into a
clocks {} grouping on a "simple-bus".

DT folks: is there a rule of thumb on how whether these fixed clocks
should be grouped on a simple bus?

Kevin
