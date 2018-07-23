From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 23 Jul 2018 08:27:47 +0530
Subject: [PATCH] ARM: dts: spear: fix stmpe811 interrupt properties
In-Reply-To: <20180720075356.26156-1-marcel@ziswiler.com>
References: <20180720075356.26156-1-marcel@ziswiler.com>
Message-ID: <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-07-18, 09:53, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> The property "irq-over-gpio" simply does not exist (this is nowadays
> actually auto detected) and the property "irq-gpios" is actually called
> "irq-gpios".

  "irq-gpio" ?

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/spear320-hmi.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 0d0da1f65f0e..d2d1fe944407 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -241,8 +241,7 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <0x41>;
> -					irq-over-gpio;
> -					irq-gpios = <&gpiopinctrl 29 0x4>;
> +					irq-gpio = <&gpiopinctrl 29 0x4>;
>  					id = <0>;
>  					blocks = <0x5>;
>  					irq-trigger = <0x1>;

-- 
viresh
