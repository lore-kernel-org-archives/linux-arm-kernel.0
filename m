From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Jun 2018 12:49:43 -0700
Subject: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
In-Reply-To: <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
> Cygnus SoC
> 
> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")

This appears to be the only one that is truly needed here, the two
others below probably just moved things around but the offending commit
was already introduced in the above commit.

> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
> 

There is no need for an extra line between the last Fixes: tag and your
Signed-off-by tag.

> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 9fe4f5a..835a6f7 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -216,7 +216,7 @@
>  			reg = <0x18008000 0x100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency = <100000>;
>  			status = "disabled";
>  		};
> @@ -245,7 +245,7 @@
>  			reg = <0x1800b000 0x100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency = <100000>;
>  			status = "disabled";
>  		};
> 


-- 
Florian
