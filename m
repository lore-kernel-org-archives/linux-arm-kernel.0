From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 26 Apr 2014 20:28:32 +0200
Subject: [linux-sunxi] [PATCH] ARM: sun7i: Fix i2c4 base address
In-Reply-To: <1397848511-30160-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397848511-30160-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <535BFAD0.6030804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/18/2014 09:15 PM, Maxime Ripard wrote:
> For some reason, the base address of the fifth I2C adapter in the A20 was
> incorrect. Change this to the actual base address.
> 
> Reported-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

The datasheet agrees with this change:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 899fd0e2b749..9dd904d53bd3 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -821,9 +821,9 @@
>  			#size-cells = <0>;
>  		};
>  
> -		i2c4: i2c at 01c2bc00 {
> +		i2c4: i2c at 01c2c000 {
>  			compatible = "allwinner,sun4i-i2c";
> -			reg = <0x01c2bc00 0x400>;
> +			reg = <0x01c2c000 0x400>;
>  			interrupts = <0 89 4>;
>  			clocks = <&apb1_gates 15>;
>  			clock-frequency = <100000>;
> 
