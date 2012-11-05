From: monstr@monstr.eu (Michal Simek)
Date: Mon, 5 Nov 2012 14:02:32 +0100
Subject: [PATCH 8/8] clocksource: xilinx_ttc: add OF_CLK support
In-Reply-To: <0ea1ba71afb3f4551ac27a6dfa41bd97b63cef48.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <0ea1ba71afb3f4551ac27a6dfa41bd97b63cef48.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3d+3CMo1bfJgWexkkgmOFyj9dp-2H4nzKygXOc94LoW0+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> Add support for retrieving TTC configuration from device tree.  This
> includes the ability to pull information about the driving clocks from
> the of_clk bindings.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi |  53 ++++++++
>  arch/arm/boot/dts/zynq-zc702.dts |  10 ++
>  drivers/clocksource/xilinx_ttc.c | 273 ++++++++++++++++++++++-----------------
>  3 files changed, 218 insertions(+), 118 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 5fb763f..9a2442c 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -109,5 +109,58 @@
>                                 };
>                         };
>                 };
> +
> +               ttc0: ttc0 at f8001000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "xlnx,ttc";
> +                       reg = <0xF8001000 0x1000>;
> +                       clocks = <&cpu_clk 3>;
> +                       clock-names = "cpu_1x";
> +                       clock-ranges;
> +
> +                       ttc0_0: ttc0.0 {
> +                               status = "disabled";
> +                               reg = <0>;
> +                               interrupts = <0 10 4>;
> +                       };
> +                       ttc0_1: ttc0.1 {
> +                               status = "disabled";
> +                               reg = <1>;
> +                               interrupts = <0 11 4>;
> +                       };
> +                       ttc0_2: ttc0.2 {
> +                               status = "disabled";
> +                               reg = <2>;
> +                               interrupts = <0 12 4>;
> +                       };
> +               };
> +
> +               ttc1: ttc0 at f8002000 {

Also this is ttc1: ttc1.
These type of faults can be simple removed by proper dts node generation.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
