From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 28 Feb 2018 01:54:57 +0000
Subject: [linux-sunxi] [PATCH v2 3/4] ARM: dts: add pwm status for r40.
In-Reply-To: <20180225135225.GA14544@arx-s1>
References: <20180225135225.GA14544@arx-s1>
Message-ID: <0fd023da-214a-c4ef-63f7-0cc41ca716bf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the subject line should mention the BananaPi M2 Ultra board.

Otherwise this looks good, although I wonder if this should somehow
mention "LCD-PWM" (in the commit message?), since this is how this pin
is described in the BananaPi GPIO documentation for this board.
And it seems to be dedicated for this purpose here.

Cheers,
Andre.

On 25/02/18 13:52, hao_zhang wrote:
> This patch adds pwm status for r40.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 8c5efe2..e4eb074 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -196,6 +196,12 @@
>  	status = "okay";
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_ch0_pin>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;
> 
