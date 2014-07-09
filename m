From: jerome.forissier@huawei.com (Jerome FORISSIER)
Date: Wed, 9 Jul 2014 09:08:39 +0200
Subject: [PATCH 1/3] mtd: hisilicon: add device tree node for nand
 controller
In-Reply-To: <1404115409-20200-2-git-send-email-wangzhou.bry@gmail.com>
References: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
 <1404115409-20200-2-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <53BCEA77.2080004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-Jun-14 10:03, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
> ---
>  arch/arm/boot/dts/hip04.dtsi |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index abb42ca..e63fc61 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -386,5 +386,36 @@
>  				interrupts = <0 389 4>;
>  			};
>  		};
> +
> +		nand: nand at 4020000 {
> +			compatible = "hisilicon,504-nfc";

In PATCH 2/3 and 3/3 you are using "hisilicon,nfc504".

> +			reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
> +			interrupts = <0 379 4>;
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "none";
> +			hisi,nand-ecc-bits = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "nand_text";
> +				reg = <0x00000000 0x00400000>;
> +			};
> +
> +			partition at 00400000 {
> +				label = "nand_monitor";
> +				reg = <0x00400000 0x00400000>;
> +			};
> +
> +			partition at 00800000 {
> +				label = "nand_kernel";
> +				reg = <0x00800000 0x00800000>;
> +			};
> +
> +			partition at 01000000 {
> +				label = "nand_fs";
> +				reg = <0x01000000 0x1f000000>;
> +			};
> +		};
>  	};
>  };
> 

-- 
Jerome
