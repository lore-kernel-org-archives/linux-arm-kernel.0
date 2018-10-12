From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 12 Oct 2018 10:42:16 -0700
Subject: [PATCH 6/6] arm64: dts: marvell: Add cpu clock node on Armada
 7K/8K
In-Reply-To: <20180922181709.13007-7-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-7-gregory.clement@bootlin.com>
Message-ID: <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Rob

Quoting Gregory CLEMENT (2018-09-22 11:17:09)
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 4a65e4e830aa..27c840e91abe 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -280,6 +280,12 @@
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
>  
> +                               cpu_clk: clock-cpu {
> +                                       compatible = "marvell,ap806-cpu-clock";
> +                                       clocks = <&ap_clk 0>, <&ap_clk 1>;
> +                                       #clock-cells = <1>;
> +                               };

This looks like the wrong place because there isn't a reg property. It
should go to the root of the tree. And then it looks like we're adding
something to DT to get a driver to probe, which is improper DT design.
