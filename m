From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 5 Mar 2017 17:13:34 -0800
Subject: [PATCH v2 3/3] ARM: dts: bcm5301x: Add I2C support to the DT
In-Reply-To: <1488500494-20622-4-git-send-email-jon.mason@broadcom.com>
References: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
 <1488500494-20622-4-git-send-email-jon.mason@broadcom.com>
Message-ID: <bb91cbbd-f5e5-9ce8-e925-89e6f831e50c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/02/2017 04:21 PM, Jon Mason wrote:
> From: Jon Mason <jonmason@broadcom.com>
> 
> Add I2C support to the bcm5301x Device Tree.  Since no driver changes
> are needed to enable this hardware, only the device tree changes are
> required to make this functional.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 4e3fbce..2a343f2 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -338,6 +338,15 @@
>  		};
>  	};
>  
> +	i2c0: i2c at 18009000 {
> +		compatible = "brcm,iproc-i2c";
> +		reg = <0x18009000 0x50>;
> +		interrupts = <GIC_SPI 121 IRQ_TYPE_NONE>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <100000>;

Should not this have a:
		status = "disabled"

property by default such that boards can override this by phandle when
there are actual I2C devices available?

> +	};
> +
>  	lcpll0: lcpll0 at 1800c100 {
>  		#clock-cells = <1>;
>  		compatible = "brcm,nsp-lcpll0";
> 

-- 
Florian
