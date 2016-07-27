From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 18:04:18 +0200
Subject: [PATCH 05/18] ARM: mvebu: a385-db-ap: add default partition
 description for NAND
In-Reply-To: <1469105055-25181-6-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:01 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-6-git-send-email-jaz@semihalf.com>
Message-ID: <87k2g7m5j1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
It looks good:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index a18f516..6648a3f 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -182,15 +182,35 @@
>  
>  			nfc: flash at d0000 {
>  				status = "okay";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -
>  				num-cs = <1>;
>  				nand-ecc-strength = <4>;
>  				nand-ecc-step-size = <512>;
>  				marvell,nand-keep-config;
>  				marvell,nand-enable-arbiter;
>  				nand-on-flash-bbt;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition at 0 {
> +						label = "U-Boot";
> +						reg = <0x00000000 0x00800000>;
> +						read-only;
> +					};
> +
> +					partition at 800000 {
> +						label = "uImage";
> +						reg = <0x00800000 0x00400000>;
> +						read-only;
> +					};
> +
> +					partition at c00000 {
> +						label = "Root";
> +						reg = <0x00c00000 0x3f400000>;
> +					};
> +				};
>  			};
>  
>  			usb3 at f0000 {
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
