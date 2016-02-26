From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2016 11:11:27 -0800
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
In-Reply-To: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20160226191127.GE13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [160224 02:14]:
> DRA7 SoC has the capability to support DDR memory upto 4GB. In order to
> represent this in memory dt node, the address-cells and size cells
> should be 2. So, changing the address-cells and size-cells to 2 and
> updating the memory nodes accordingly.
> @@ -57,10 +57,10 @@
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48211000 0x1000>,
> -		      <0x48212000 0x1000>,
> -		      <0x48214000 0x2000>,
> -		      <0x48216000 0x2000>;
> +		reg = <0x0 0x48211000 0x0 0x1000>,
> +		      <0x0 0x48212000 0x0 0x1000>,
> +		      <0x0 0x48214000 0x0 0x2000>,
> +		      <0x0 0x48216000 0x0 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>  		interrupt-parent = <&gic>;
>  	};
> @@ -69,7 +69,7 @@
>  		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48281000 0x1000>;
> +		reg = <0x0 0x48281000 0x0 0x1000>;
>  		interrupt-parent = <&gic>;
>  	};
>  
> @@ -96,10 +96,10 @@
>  		compatible = "ti,dra7-l3-noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges;
> +		ranges = <0x0 0x0 0x0 0xc0000000>;
>  		ti,hwmods = "l3_main_1", "l3_main_2";
> -		reg = <0x44000000 0x1000000>,
> -		      <0x45000000 0x1000>;
> +		reg = <0x0 0x44000000 0x0 0x1000000>,
> +		      <0x0 0x45000000 0x0 0x1000>;
>  		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>  				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  

Is size-cells 2 needed for all these devices too? Can't
you just set it for the memory nodes?

Regards,

Tony
