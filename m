From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 23:32:42 -0700
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <20180530141133.3711-6-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
Message-ID: <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Faiz Abbas (2018-05-30 07:11:32)
> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
> index bfc82636999c..57b8dc0fe719 100644
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -11,6 +11,25 @@
>  / {
>         compatible = "ti,dra762", "ti,dra7";
>  
> +       ocp {
> +
> +               target-module at 0x42c00000 {

Drop the 0x on unit address. Also, it should match the first register
property. And what is a "target-module"?

> +                       compatible = "ti,sysc-dra7-mcan";
> +                       ranges = <0x0 0x42c00000 0x2000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       reg = <0x42c01900 0x4>,
> +                             <0x42c01904 0x4>,
> 
