From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 14 Dec 2017 12:17:46 +0100
Subject: [PATCH v2 3/3] arm: dts: mt7623: fix card detection issue on
 bananapi-r2
In-Reply-To: <e71b755467ce9a1f8bf78e2b6cd2e1b63e8338cd.1512628593.git.sean.wang@mediatek.com>
References: <cover.1512628593.git.sean.wang@mediatek.com>
 <e71b755467ce9a1f8bf78e2b6cd2e1b63e8338cd.1512628593.git.sean.wang@mediatek.com>
Message-ID: <14ba6eb7-c9a3-f78b-e0e2-c44846aa1f76@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/07/2017 07:43 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix that bananapi-r2 booting from SD-card would fail since incorrect
> polarity is applied to the previous setup with GPIO_ACTIVE_HIGH.
> 
> Cc: stable at vger.kernel.org
> Fixes: 0eed8d097612 ("arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Tested-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 688a863..7bf5aa2 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -204,7 +204,7 @@
>  	bus-width = <4>;
>  	max-frequency = <50000000>;
>  	cap-sd-highspeed;
> -	cd-gpios = <&pio 261 0>;
> +	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
>  	vmmc-supply = <&mt6323_vmch_reg>;
>  	vqmmc-supply = <&mt6323_vio18_reg>;
>  };
> 

2 and 3 pushed to v4.15-next/dts32

Thanks!
