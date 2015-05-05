From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 14:29:13 +0200
Subject: [PATCH 8/9] ARM: tegra: colibri t30: activate stmpe811 touch
 controller
In-Reply-To: <d87e59343cc07b99f85fc6dcb6cc8fe941770f30.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <d87e59343cc07b99f85fc6dcb6cc8fe941770f30.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <20150505122911.GG30501@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:36:03PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Activate STMPE811 touch controller as found on Colibri T30 modules.
> While at it change order of HDMI sub nodes as well to be more in line
> with Apalis T30.
> While at it also update comment about supported module hardware
> versions.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> coli
> ---
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 +--
>  arch/arm/boot/dts/tegra30-colibri.dtsi        | 44 +++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
> index 4d3ddc5..d42c400 100644
> --- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
> @@ -55,7 +55,7 @@
>  
>  		/* M41T0M6 real time clock on carrier board */
>  		rtc at 68 {
> -			compatible = "stm,m41t00";
> +			compatible = "st,m41t00";
>  			reg = <0x68>;
>  		};
>  	};

This change isn't documented in the commit message.

> @@ -84,7 +84,7 @@
>  		};
>  	};
>  
> -	sdhci at 78000200 {
> +	sdmmc: sdhci at 78000200 {
>  		status = "okay";
>  		bus-width = <4>;
>  		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;

Do you actually need this label? I suspect not, and I would suspect that
you don't need it on Apalis either, so I think a better patch would just
remove it from Apalis as well.

> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index c4ed1be..5f7f4a0 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -3,7 +3,7 @@
>  
>  /*
>   * Toradex Colibri T30 Device Tree
> - * Compatible for Revisions 1.1B/1.1C/1.1D
> + * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E; IT: V1.1A
>   */
>  / {
>  	model = "Toradex Colibri T30";
> @@ -18,9 +18,9 @@
>  			vdd-supply = <&sys_3v3_reg>;
>  			pll-supply = <&vio_reg>;
>  
> +			nvidia,ddc-i2c-bus = <&hdmiddc>;
>  			nvidia,hpd-gpio =
>  				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
> -			nvidia,ddc-i2c-bus = <&hdmiddc>;
>  		};
>  	};

There's too many changes crammed into this commit for my taste. Can you
please separate these out into smaller commits and resend?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/3e403087/attachment-0001.sig>
