From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Sep 2016 09:04:25 +0200
Subject: [PATCH v2 4/7] dts: sun8i-h3: add UART1-3 to Orange Pi Plus
In-Reply-To: <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
Message-ID: <20160902070425.GB6313@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 31, 2016 at 09:30:55PM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> This board has UARTS1-3 exposed on its expansion header
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index b0cb417..7a17839 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -90,6 +90,21 @@
>  	};
>  };
>  
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins_a>;
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins_a>;
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins_a>;
> +};
> +

Unfortunately, these pins can be used for other purposes as well, so
we cannot make force that decision down to our users.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/b90f2714/attachment.sig>
