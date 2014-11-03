From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Nov 2014 14:21:15 +0800
Subject: [PATCH] ARM: dts: imx6sx-sdb: Allow wakeup from buttons
In-Reply-To: <1414614311-2199-1-git-send-email-festevam@gmail.com>
References: <1414614311-2199-1-git-send-email-festevam@gmail.com>
Message-ID: <20141103062114.GE10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 06:25:11PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Allow the two button wakeup the system from low power mode.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 448489b..80ae281 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -39,12 +39,14 @@
>  		volume-up {
>  			label = "Volume Up";
>  			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
> +			gpio-key,wakeup;

I can understand that this is convenient for developers, but I'm not
really sure if it's reasonable for users.  IOW, is it expected that
volume keys can wake up system from low power mode?  Or we should only
allow that from power key?

Shawn

>  			linux,code = <KEY_VOLUMEUP>;
>  		};
>  
>  		volume-down {
>  			label = "Volume Down";
>  			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
> +			gpio-key,wakeup;
>  			linux,code = <KEY_VOLUMEDOWN>;
>  		};
>  	};
> -- 
> 1.9.1
> 
