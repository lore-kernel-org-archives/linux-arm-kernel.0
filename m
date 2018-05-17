From: vincent.weaver@maine.edu (Vince Weaver)
Date: Thu, 17 May 2018 10:11:02 -0400 (EDT)
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <20180517131727.29263-1-eric@anholt.net>
References: <20180517131727.29263-1-eric@anholt.net>
Message-ID: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018, Eric Anholt wrote:

> diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
> index 7704bb029605..1f5e5c782835 100644
> --- a/arch/arm/boot/dts/bcm2837.dtsi
> +++ b/arch/arm/boot/dts/bcm2837.dtsi
> @@ -17,6 +17,12 @@
>  		};
>  	};
>  
> +	arm-pmu {
> +		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
> +		interrupt-parent = <&local_intc>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +

why this and not

arm-pmu {
	compatible = "arm,armv8-pmuv3";
	interrupt-parent = <&local_intc>;
	interrupts = <9>;
};

which works, though when I didn't get very far when I submitted the patch 
to add this last August.

Vince
