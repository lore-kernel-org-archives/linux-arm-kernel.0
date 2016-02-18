From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 23:04:35 +0800
Subject: [PATCH] ARM: dts: vf-colibri: disable write-protection for SD-card
In-Reply-To: <1455752656-4040-1-git-send-email-stefan@agner.ch>
References: <1455752656-4040-1-git-send-email-stefan@agner.ch>
Message-ID: <20160218150434.GD6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 03:44:16PM -0800, Stefan Agner wrote:
> The Colibri standard does not define a pin for SD-Card write-
> protection. Use the disable-wp property to indicate that there
> is no physical WP line present.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

> ---
>  arch/arm/boot/dts/vf-colibri.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index ff6f58e..e49bbbc 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -92,6 +92,7 @@
>  	pinctrl-0 = <&pinctrl_esdhc1>;
>  	bus-width = <4>;
>  	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  };
>  
>  &fec1 {
> -- 
> 2.7.1
> 
> 
