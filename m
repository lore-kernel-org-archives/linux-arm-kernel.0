From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 27 Jul 2016 07:51:33 -0700
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for
 rk3368 SoCs
In-Reply-To: <1469629447-544-3-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-3-git-send-email-wxt@rock-chips.com>
Message-ID: <5798CA75.3010202@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2016 07:24 AM, Caesar Wang wrote:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Changes in v3:
> - add Doug's reviewed tag.
>
Not to this patch ?

> Changes in v2: None
>
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index d02a9003..4f44d11 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -270,6 +270,8 @@
>   		#io-channel-cells = <1>;
>   		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>   		clock-names = "saradc", "apb_pclk";
> +		resets = <&cru SRST_SARADC>;
> +		reset-names = "saradc-apb";
>   		status = "disabled";
>   	};
>
>
