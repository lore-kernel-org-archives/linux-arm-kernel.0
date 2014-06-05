From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 08:51:41 +0100
Subject: [STLinux Kernel] [PATCH RESEND 02/12] clk: st: Adds Flexgen
 clock binding
In-Reply-To: <1401892320-18211-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605075141.GB3865@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabi,

> +Example:
> +
> +	clockgenD2 at x9106000 {
> +		compatible = "st,clkgen-c32";
> +		reg = <0x9106000 0x1000>;
> +
> +		CLK_S_D2_FLEXGEN: CLK_S_D2_FLEXGEN {
> +			compatible = "st,flexgen";
> +
> +			#clock-cells = <1>;
> +			clocks = <&CLK_S_D2_QUADFS 0>,
> +				 <&CLK_S_D2_QUADFS 1>,
> +				 <&CLK_S_D2_QUADFS 2>,
> +				 <&CLK_S_D2_QUADFS 3>;
> +
> +			clock-output-names = "CLK_PIX_MAIN_DISP",
> +					     "CLK_PIX_PIP",
> +					     "CLK_PIX_GDP1",
> +					     "CLK_PIX_GDP2";

With the upper case to lower case renaming of the STI device tree
this example also needs to be converted to lower case names 
throughout.

Once rectified you can add my:
 Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
