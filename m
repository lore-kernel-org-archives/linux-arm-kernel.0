From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 13:56:09 -0700
Subject: [PATCH 1/6] dt-bindings: ap806: add the cluster clock node in the
 syscon file
In-Reply-To: <20180922181709.13007-2-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-2-gregory.clement@bootlin.com>
Message-ID: <153972336963.5275.5425208133793471350@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-09-22 11:17:04)
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Please Cc relevant DT maintainers and lists when submitting binding patches.

>  .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 3fd21bb7cb37..8f281816a6b8 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -136,3 +136,25 @@ ap_syscon1: system-controller at 6f8000 {
>                 #thermal-sensor-cells = <1>;
>         };
>  };
> +
> +Cluster clocks:
> +---------------
> +
> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> +cluster contain up to 2 CPUs running at the same frequency.
> +
> +Required properties:
> +- compatible: must be  "marvell,ap806-cpu-clock";
> +- #clock-cells : should be set to 1.
> +- clocks : shall be the input parents clock phandle for the clock.
> +
> +ap_syscon1: system-controller at 6f8000 {
> +       compatible = "syscon", "simple-mfd";
> +       reg = <0x6f8000 0x1000>;
> +
> +       cpu_clk: clock-cpu {
> +               compatible = "marvell,ap806-cpu-clock";
> +               clocks = <&ap_clk 0>, <&ap_clk 1>;
> +               #clock-cells = <1>;
> +       };
> +};
