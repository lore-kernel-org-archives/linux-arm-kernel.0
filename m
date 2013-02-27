From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Feb 2013 13:55:09 +0530
Subject: [PATCH 4/4] ARM: davinci: da850-evm: add SPI flash support
In-Reply-To: <1361789050-637-5-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
 <1361789050-637-5-git-send-email-prakash.pm@ti.com>
Message-ID: <512DC2E5.4080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> Enable m25p80 SPI flash support on da850-EVM. Also
> add partition information of SPI flash.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 78c8e54..1a28d43 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -46,6 +46,46 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&mmc0_pins>;
>  		};
> +		spi1: spi at 1f0e000 {
> +			status = "okay";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi1_pins>;
> +			flash: m25p80 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "m25p80";

Are you sure there is a m25p80 part on these boards? On my board using
this patch I get:

m25p80 spi32766.0: found m25p64, expected m25p80

I can access the flash just fine though.

Thanks,
Sekhar
