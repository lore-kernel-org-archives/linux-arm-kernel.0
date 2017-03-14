From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Mar 2017 15:28:48 +0800
Subject: [PATCH] ARM: dts: imx6q-bx50v3/imx6q-b450v3/imx6q-b650v3: fix
 at25 spi-clk frequency issue
In-Reply-To: <20170303212032.31725-1-yungching0725@gmail.com>
References: <20170303212032.31725-1-yungching0725@gmail.com>
Message-ID: <20170314072846.GJ3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 04, 2017 at 05:20:32AM +0800, Ken Lin wrote:
> Change the maxium spi clock frequency from 20MHz to 10MHz to meet the operation voltage range requirement recommended in AT25 datasheet

The commit log should be wrapped around column 72 to make it easier for
read.

The subject prefix is unnecessarily too long, as it only changes
imx6q-bx50v3.dtsi.

I fixed them this time, and apply the patch.

Shawn

> 
> Signed-off-by: Ken Lin <yungching0725@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-bx50v3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> index f99e6efda3e2..614c40e5f772 100644
> --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> @@ -103,7 +103,7 @@
>  
>  	m25_eeprom: m25p80 at 0 {
>  		compatible = "atmel,at25";
> -		spi-max-frequency = <20000000>;
> +		spi-max-frequency = <10000000>;
>  		size = <0x8000>;
>  		pagesize = <64>;
>  		reg = <0>;
> -- 
> 2.11.0
> 
