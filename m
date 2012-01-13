From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 13 Jan 2012 06:14:17 +0000
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller
 bindings for INTC
In-Reply-To: <1324388398-2683-5-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-5-git-send-email-b-cousson@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317A43FC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 19:09:57, Cousson, Benoit wrote:
> Update the DTS with the proper information required by the
> INTC bindings.
> 
> - Add the number of interrupt lines
> - Add the reg and the compatible entries.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/omap3.dtsi |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..6866dc7 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -54,10 +54,12 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> -		intc: interrupt-controller at 1 {
> -			compatible = "ti,omap3-intc";
> +		intc: interrupt-controller at 48200000 {
> +			compatible = "ti,omap2-intc";
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> +			ti,intc-size = <96>;
Can we configure/change this field in platform specific .dts file?
OR
Is there condition based configuration possible in DT?

To be specific,

I am adding support for AM335x EVM (using all your DT support patches),
The device is considered as OMAP3 variant and when it comes to INTC support,
I need to configure it to value "128", rest everything is same 
(including base add).

Can I do something like

File - am335x-evm.dts

/include/ "omap3.dtsi"

....
Again change the specific fields of " intc: interrupt-controller"?
....

How can this be handled?

Thanks,
Vaibhav
> +			reg = <0x48200000 0x1000>;
>  		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
