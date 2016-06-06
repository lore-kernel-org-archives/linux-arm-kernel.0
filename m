From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Jun 2016 20:51:24 +0200
Subject: [PATCH 7/7] ARM: dts: sun7i: Enable NAND on Wexler TAB7200
In-Reply-To: <1465208664-9366-8-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-8-git-send-email-mamlinav@gmail.com>
Message-ID: <20160606205124.06b2f963@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  6 Jun 2016 13:24:24 +0300
Aleksei Mamlin <mamlinav@gmail.com> wrote:

> Enable the NFC and describe the NAND flash connected to this controller.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index 2f6b21a..42aff91 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -159,6 +159,47 @@
>  	status = "okay";
>  };
>  
> +&nfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
> +	status = "okay";
> +
> +	nand at 0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0>;
> +		allwinner,rb = <0>;
> +
> +		nand-ecc-mode = "hw";
> +		nand-on-flash-bbt;
> +
> +		boot0 at 0 {
> +			label = "boot0";
> +			reg = /bits/ 64 <0x0 0x200000>;
> +		};
> +
> +		boot0-rescue at 200000 {
> +			label = "boot0-rescue";
> +			reg = /bits/ 64 <0x200000 0x200000>;
> +		};
> +
> +		uboot at 400000 {
> +			label = "uboot";
> +			reg = /bits/ 64 <0x400000 0x200000>;
> +		};
> +
> +		uboot-rescue at 600000 {
> +			label = "uboot-rescue";
> +			reg = /bits/ 64 <0x600000 0x200000>;
> +		};
> +
> +		main at 800000 {
> +			label = "main";
> +			reg = /bits/ 64 <0x800000 0xff800000>;
> +		};
> +	};
> +};
> +
>  &ohci0 {
>  	status = "okay";
>  };



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
