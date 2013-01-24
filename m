From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Jan 2013 16:21:16 +0100
Subject: [PATCH 2/2] ARM: dts: omap3-overo: Add audio support
In-Reply-To: <1358963812-19947-3-git-send-email-florian.vaussard@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <5101516C.30602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/23/2013 06:56 PM, Florian Vaussard wrote:
> Add the needed sections to enable audio support on Overo.

Looks fine for me.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index 800be29..81341fa 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -23,6 +23,14 @@
>  			max-brightness = <127>;
>  		};
>  	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "overo";
> +
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -32,6 +40,12 @@
>  		reg = <0x48>;
>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>  		interrupt-parent = <&intc>;
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
>  	};
>  };
>  
> 


-- 
P?ter
