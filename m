From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 13:47:52 +0100
Subject: [PATCH v1 4/4] ARM: dts: add pwm node for r40.
In-Reply-To: <20180111113412.GA22008@arx-s1>
References: <20180111113412.GA22008@arx-s1>
Message-ID: <20180111124752.2ljspnaclwgz2s62@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 11, 2018 at 07:34:12PM +0800, hao_zhang wrote:
> This patch add pwm node for r40.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 173dcc1..84c963c 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -295,6 +295,11 @@
>  				bias-pull-up;
>  			};
>  
> +			pwm_pins: pwm-pins {
> +				pins = "PB2", "PB3";
> +				function = "pwm";
> +			};
> +

Is it the only combination of pins that is usable?

If so, you can add the pinctrl-0 property directly in the pwm nodes.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/42ba49ea/attachment.sig>
