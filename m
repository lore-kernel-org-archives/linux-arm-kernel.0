From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 May 2013 09:27:58 +0100
Subject: [PATCH] ARM: ux500: enable the crypto and hash on all dbx500
In-Reply-To: <1369378122-25897-1-git-send-email-linus.walleij@stericsson.com>
References: <1369378122-25897-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130524082758.GP22683@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 May 2013, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Commits:
> "ARM: ux500: Add Device Tree nodes for the ux500 Crypt device"
> "ARM: ux500: Add Device Tree nodes for the ux500 Hash device"
> 
> Added the crypto and hash devices conditionally, i.e. so as to
> be turned on per-board by setting an "status" property on the
> device from "disabled" to "okay" on each device.
> 
> This is wrong since this is an SoC feature, it is not board
> dependent. It is the same ASIC under all circumstances and
> functionality does not vary with board family.
> 
> This moves the enablement into the SoC file.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/dbx5x0.dtsi  | 4 ----
>  arch/arm/boot/dts/snowball.dts | 8 --------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
> index f051963..cd5cd09 100644
> --- a/arch/arm/boot/dts/dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/dbx5x0.dtsi
> @@ -760,17 +760,13 @@
>  			compatible = "stericsson,ux500-cryp";
>  			reg = <0xa03cb000 0x1000>;
>  			interrupts = <0 15 0x4>;
> -

Why do you insist on removing all line spacings from the DTS file?

I saw you removing them in between nodes too.

>  			v-ape-supply = <&db8500_vape_reg>;
> -			status = "disabled";
>  		};
>  
>  		hash at a03c2000 {
>  			compatible = "stericsson,ux500-hash";
>  			reg = <0xa03c2000 0x1000>;
> -
>  			v-ape-supply = <&db8500_vape_reg>;
> -			status = "disabled";
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
> index bda002f..e8219cc7 100644
> --- a/arch/arm/boot/dts/snowball.dts
> +++ b/arch/arm/boot/dts/snowball.dts
> @@ -356,13 +356,5 @@
>  				};
>  			};
>  		};
> -
> -		cryp at a03cb000 {
> -			status = "okay";
> -		};
> -
> -		hash at a03c2000 {
> -			status = "okay";
> -		};
>  	};
>  };

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
