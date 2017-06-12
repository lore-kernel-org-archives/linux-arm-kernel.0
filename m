From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 12 Jun 2017 09:38:55 +0200
Subject: [PATCH] ARM: dts: meson8: fix the IR receiver pins
In-Reply-To: <20170609222039.25191-1-martin.blumenstingl@googlemail.com>
References: <20170609222039.25191-1-martin.blumenstingl@googlemail.com>
Message-ID: <e4347b01-e221-2242-9bb9-bc1e93da06fb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2017 12:20 AM, Martin Blumenstingl wrote:
> The IR receiver pins are currently defined in the CBUS pin-controller.
> However the pins are in the AO region, which is controlled by the AOBUS
> pin-controller. Move the pins to pinctrl_aobus so they can actually be
> used.
> 
> Fixes: b60e1157d8fa ("ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 9b0b3ddbb17e..e4f7357b4b31 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -116,6 +116,13 @@
>  				function = "i2c_mst_ao";
>  			};
>  		};
> +
> +		ir_recv_pins: remote {
> +			mux {
> +				groups = "remote_input";
> +				function = "remote";
> +			};
> +		};
>  	};
>  };
>  
> @@ -151,13 +158,6 @@
>  			};
>  		};
>  
> -		ir_recv_pins: remote {
> -			mux {
> -				groups = "remote_input";
> -				function = "remote";
> -			};
> -		};
> -
>  		eth_pins: ethernet {
>  			mux {
>  				groups = "eth_tx_clk_50m", "eth_tx_en",
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
