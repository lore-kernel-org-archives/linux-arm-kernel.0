From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 12:58:45 -0400
Subject: [PATCH 2/7] ARM: dts: lpc32xx: ea3250: add NAND partitions
 device node
In-Reply-To: <1461631050-10479-3-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
 <1461631050-10479-3-git-send-email-vz@mleia.com>
Message-ID: <1461689925.9433.14.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-04-26 at 03:37 +0300, Vladimir Zapolskiy wrote:
> To declare MTD OF partitions NAND controller device node should have
> a special 'partitions' subnode, the change removes a debug message
> from mtd/ofpart on boot:
> 
>   nxp_lpc3220_slc: 'partitions' subnode not found on /ahb/flash at 20020000.
>   Trying to parse direct subnodes as partitions.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/ea3250.dts | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
> index 7cf815a..58bcda9 100644
> --- a/arch/arm/boot/dts/ea3250.dts
> +++ b/arch/arm/boot/dts/ea3250.dts
> @@ -213,8 +213,6 @@
>  
>  /* 128MB Flash via SLC NAND controller */
>  &slc {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
>  	status = "okay";
>  
>  	nxp,wdr-clks = <14>;
> @@ -228,26 +226,31 @@
>  	nand-on-flash-bbt;
>  	gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
>  
> -	mtd0 at 00000000 {
> -		label = "ea3250-boot";
> -		reg = <0x00000000 0x00080000>;
> -		read-only;
> -	};
> +	partitions {

You may want to add the compatible property to the partitions here:
+		compatible = "fixed-partitions";

Refer to commit e488ca9f8d4f62c2dc36bfa5c32f68e7f05ab381 for details.

This suggestion is also valid for patch #6.

Note:
This change was required to use the "partitions" subnode
on my custom LPC3250 board definition.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  
...
Sylvain
 
