From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Jun 2018 12:50:19 -0700
Subject: [PATCH 2/5] ARM: dts: cygnus: Fix PCIe controller interrupt type
In-Reply-To: <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
> Cygnus SoC
> 
> Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")

This one is valid

> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
> bus")
> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
> Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")

And this one too, but the two others, I would probably drop them so we
can get the backports to be possibly applicable as far as when these two
commits can be resolved, does that work?

> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 835a6f7..2c4df2d 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -256,7 +256,7 @@
>  
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			linux,pci-domain = <0>;
>  
> @@ -278,10 +278,10 @@
>  				compatible = "brcm,iproc-msi";
>  				msi-controller;
>  				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 97 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 98 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 99 IRQ_TYPE_NONE>;
> +				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
>  
> @@ -291,7 +291,7 @@
>  
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			linux,pci-domain = <1>;
>  
> @@ -313,10 +313,10 @@
>  				compatible = "brcm,iproc-msi";
>  				msi-controller;
>  				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 103 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 104 IRQ_TYPE_NONE>,
> -					     <GIC_SPI 105 IRQ_TYPE_NONE>;
> +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
>  
> 


-- 
Florian
