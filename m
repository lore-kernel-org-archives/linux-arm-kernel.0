From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Apr 2014 21:21:39 -0700
Subject: [PATCH v7 2/3] clk: exynos5410: register clocks using common clock
 framework
In-Reply-To: <1393213435-20863-3-git-send-email-t.dakhran@samsung.com>
References: <1393213435-20863-1-git-send-email-t.dakhran@samsung.com>
 <1393213435-20863-3-git-send-email-t.dakhran@samsung.com>
Message-ID: <20140403042139.5762.23354@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tarek Dakhran (2014-02-23 19:43:54)
> +External clock:
> +
> +There is clock that is generated outside the SoC. It is expected
> +that it is defined using standard clock bindings with following
> +clock-output-name:
> + - "fin_pll" - PLL input clock - required.

<snip>

> +Example 2: Required external clock.
> +
> +       fin_pll: clock-fin-pll {
> +               compatible = "fixed-clock";
> +               reg = <0>;
> +               #clock-cells = <0>;
> +               clock-frequency = <24000000>;
> +               clock-output-names = "fin_pll";
> +       };

I guess this part is a little strange for a binding definition.
Basically this is DTS data specific to 5410; not sure why it belongs in
the DT binding definition.

Rest of the clock driver appears OK to me.

Regards,
Mike
