From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 27 Mar 2013 06:30:21 -0300
Subject: [PATCH 1/2] clk: sunxi: rename compatible strings
In-Reply-To: <20130327084051.4014.43234@quantum>
References: <1364351958-14503-1-git-send-email-emilio@elopez.com.ar>
 <1364351958-14503-2-git-send-email-emilio@elopez.com.ar>
 <20130327084051.4014.43234@quantum>
Message-ID: <5152BC2D.6000208@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 27/03/13 05:40, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-03-26 19:39:17)
>> During the introduction of the Allwinner SoC platforms, sunxi was
>> initially meant as a generic name for all the variants of the Allwinner
>> SoC.
>>
>> It was ok at the time of the support of only the A10 and A13 that
>> look pretty much the same; but it's beginning to be troublesome with
>> the future addition of the Allwinner A31 (sun6i) that is quite
>> different, and would introduce some weird logic, where sunxi would
>> actually mean in some case sun4i and sun5i but without sun6i...
>>
>> Moreover, it makes the compatible strings naming scheme not consistent
>> with other architectures, where usually for this kind of compability, we
>> just use the oldest SoC name that has this IP, so let's do just this.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> Which tree did you want this patch to go through?

This one should go through your tree, as you have the rest of the driver
on it.

Thanks,

Emilio

> 
> Regards,
> Mike
> 
>> ---
>>
>> These compatible strings have never been on a released kernel, so
>> changing them now shouldn't cause any issues. Also see Maxime's
>> "ARM: sunxi: Architecture cleanups and rework" which does the same for
>> the rest of sunxi code.
>>
>>  Documentation/devicetree/bindings/clock/sunxi.txt | 22 +++++++++++-----------
>>  drivers/clk/sunxi/clk-sunxi.c                     | 16 ++++++++--------
>>  2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index b23cfbd..20b8479 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -6,14 +6,14 @@ This binding uses the common clock binding[1].
>>  
>>  Required properties:
>>  - compatible : shall be one of the following:
>> -       "allwinner,sunxi-osc-clk" - for a gatable oscillator
>> -       "allwinner,sunxi-pll1-clk" - for the main PLL clock
>> -       "allwinner,sunxi-cpu-clk" - for the CPU multiplexer clock
>> -       "allwinner,sunxi-axi-clk" - for the sunxi AXI clock
>> -       "allwinner,sunxi-ahb-clk" - for the sunxi AHB clock
>> -       "allwinner,sunxi-apb0-clk" - for the sunxi APB0 clock
>> -       "allwinner,sunxi-apb1-clk" - for the sunxi APB1 clock
>> -       "allwinner,sunxi-apb1-mux-clk" - for the sunxi APB1 clock muxing
>> +       "allwinner,sun4i-osc-clk" - for a gatable oscillator
>> +       "allwinner,sun4i-pll1-clk" - for the main PLL clock
>> +       "allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
>> +       "allwinner,sun4i-axi-clk" - for the AXI clock
>> +       "allwinner,sun4i-ahb-clk" - for the AHB clock
>> +       "allwinner,sun4i-apb0-clk" - for the APB0 clock
>> +       "allwinner,sun4i-apb1-clk" - for the APB1 clock
>> +       "allwinner,sun4i-apb1-mux-clk" - for the APB1 clock muxing
>>  
>>  Required properties for all clocks:
>>  - reg : shall be the control register address for the clock.
>> @@ -24,21 +24,21 @@ For example:
>>  
>>  osc24M: osc24M at 01c20050 {
>>         #clock-cells = <0>;
>> -       compatible = "allwinner,sunxi-osc-clk";
>> +       compatible = "allwinner,sun4i-osc-clk";
>>         reg = <0x01c20050 0x4>;
>>         clocks = <&osc24M_fixed>;
>>  };
>>  
>>  pll1: pll1 at 01c20000 {
>>         #clock-cells = <0>;
>> -       compatible = "allwinner,sunxi-pll1-clk";
>> +       compatible = "allwinner,sun4i-pll1-clk";
>>         reg = <0x01c20000 0x4>;
>>         clocks = <&osc24M>;
>>  };
>>  
>>  cpu: cpu at 01c20054 {
>>         #clock-cells = <0>;
>> -       compatible = "allwinner,sunxi-cpu-clk";
>> +       compatible = "allwinner,sun4i-cpu-clk";
>>         reg = <0x01c20054 0x4>;
>>         clocks = <&osc32k>, <&osc24M>, <&pll1>;
>>  };
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index d4ad1c2..d528a24 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -305,29 +305,29 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>>  /* Matches for of_clk_init */
>>  static const __initconst struct of_device_id clk_match[] = {
>>         {.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
>> -       {.compatible = "allwinner,sunxi-osc-clk", .data = sunxi_osc_clk_setup,},
>> +       {.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
>>         {}
>>  };
>>  
>>  /* Matches for factors clocks */
>>  static const __initconst struct of_device_id clk_factors_match[] = {
>> -       {.compatible = "allwinner,sunxi-pll1-clk", .data = &pll1_data,},
>> -       {.compatible = "allwinner,sunxi-apb1-clk", .data = &apb1_data,},
>> +       {.compatible = "allwinner,sun4i-pll1-clk", .data = &pll1_data,},
>> +       {.compatible = "allwinner,sun4i-apb1-clk", .data = &apb1_data,},
>>         {}
>>  };
>>  
>>  /* Matches for divider clocks */
>>  static const __initconst struct of_device_id clk_div_match[] = {
>> -       {.compatible = "allwinner,sunxi-axi-clk", .data = &axi_data,},
>> -       {.compatible = "allwinner,sunxi-ahb-clk", .data = &ahb_data,},
>> -       {.compatible = "allwinner,sunxi-apb0-clk", .data = &apb0_data,},
>> +       {.compatible = "allwinner,sun4i-axi-clk", .data = &axi_data,},
>> +       {.compatible = "allwinner,sun4i-ahb-clk", .data = &ahb_data,},
>> +       {.compatible = "allwinner,sun4i-apb0-clk", .data = &apb0_data,},
>>         {}
>>  };
>>  
>>  /* Matches for mux clocks */
>>  static const __initconst struct of_device_id clk_mux_match[] = {
>> -       {.compatible = "allwinner,sunxi-cpu-clk", .data = &cpu_data,},
>> -       {.compatible = "allwinner,sunxi-apb1-mux-clk", .data = &apb1_mux_data,},
>> +       {.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_data,},
>> +       {.compatible = "allwinner,sun4i-apb1-mux-clk", .data = &apb1_mux_data,},
>>         {}
>>  };
>>  
>> -- 
>> 1.8.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
