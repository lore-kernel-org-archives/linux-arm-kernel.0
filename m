From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 18 Feb 2013 19:00:21 -0600
Subject: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
In-Reply-To: <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
 <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <5122CEA5.5010902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/28/2013 11:54 AM, Florian Vaussard wrote:
> Add device-tree support for the GPMC controller on the OMAP3.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 6c63118..2ddae38 100644
> --- a/arch/arm/boot/dts/omap3.dtsi 
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -403,5 +403,16 @@
>  			ti,timer-alwon;
>  			ti,timer-secure;
>  		};
> +
> +		gpmc: gpmc at 6e000000 {
> +			compatible = "ti,omap3430-gpmc";
> +			ti,hwmods = "gpmc";
> +			reg = <0x6e000000 0x1000000>;

Can you make this size smaller? Although the reference manual states
16MB, the registers use less than 1KB of address space. Hence, it is
pointless mapping all this address space for the gpmc registers.

> +			interrupts = <20>;
> +			gpmc,num-cs = <8>;
> +			gpmc,num-waitpins = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +		};
>  	};
>  };

Otherwise ...

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
