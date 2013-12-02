From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 10:49:24 +0100
Subject: [PATCH 1/2] ARM: AT91: Animeo IP: fix mtd partition table
In-Reply-To: <1380264496-16887-1-git-send-email-plagnioj@jcrosoft.com>
References: <1380264496-16887-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <529C57A4.60809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/2013 08:48, Jean-Christophe PLAGNIOL-VILLARD :
> Update to production one.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

This one added to at91-3.14-dt

Thanks,

> ---
>   arch/arm/boot/dts/animeo_ip.dts | 31 ++++++++-----------------------
>   1 file changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
> index cfed178..6b4b6a1 100644
> --- a/arch/arm/boot/dts/animeo_ip.dts
> +++ b/arch/arm/boot/dts/animeo_ip.dts
> @@ -101,34 +101,19 @@
>   			nand-on-flash-bbt;
>   			status = "okay";
>
> -			at91bootstrap at 0 {
> -				label = "at91bootstrap";
> -				reg = <0x0 0x8000>;
> -			};
> -
> -			barebox at 8000 {
> +			barebox at 0 {
>   				label = "barebox";
> -				reg = <0x8000 0x40000>;
> -			};
> -
> -			bareboxenv at 48000 {
> -				label = "bareboxenv";
> -				reg = <0x48000 0x8000>;
> -			};
> -
> -			user_block at 0x50000 {
> -				label = "user_block";
> -				reg = <0x50000 0xb0000>;
> +				reg = <0x0 0x58000>;
>   			};
>
> -			kernel at 100000 {
> -				label = "kernel";
> -				reg = <0x100000 0x1b0000>;
> +			u_boot_env at 58000 {
> +				label = "u_boot_env";
> +				reg = <0x58000 0x8000>;
>   			};
>
> -			root at 2b0000 {
> -				label = "root";
> -				reg = <0x2b0000 0x1D50000>;
> +			ubi at 60000 {
> +				label = "ubi";
> +				reg = <0x60000 0x1FA0000>;
>   			};
>   		};
>
>


-- 
Nicolas Ferre
