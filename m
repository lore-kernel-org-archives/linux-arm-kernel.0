From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 08:18:51 +0200
Subject: [PATCH v4 2/8] dts: sun8i-h3: clarify uart1 pinmux definition name
In-Reply-To: <1473235141-12768-3-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-3-git-send-email-jorik@kippendief.biz>
Message-ID: <20160908061851.GB8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 07, 2016 at 09:58:55AM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Commit log?

> ---
>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 +-
>  arch/arm/boot/dts/sun8i-h3.dtsi                 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> index 3779280..45f623b 100644
> --- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> @@ -185,7 +185,7 @@
>  
>  &uart1 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1_pins_a>;
> +	pinctrl-0 = <&uart1_rts_cts_pins>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index ee10004..933d42c 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -367,7 +367,7 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> -			uart1_pins_a: uart1 at 0 {
> +			uart1_rts_cts_pins: uart1_rts_cts {
>  				allwinner,pins = "PG6", "PG7", "PG8", "PG9";

I'd prefer to have one pinctrl node for RX/TX, and one for
RTS/CTS. That way, we don't have to duplicate the nodes for the boards
that want to enable only RX/TX

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/611da8dc/attachment.sig>
