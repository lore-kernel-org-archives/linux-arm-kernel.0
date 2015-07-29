From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 29 Jul 2015 09:57:29 +0900
Subject: [PATCH v3] ARM: dts: Add SPI CS on exynos5250-snow
In-Reply-To: <e1952e8c102a3b7a7f3f79c759c44093e0d11dc7.1438073049.git.hramrach@gmail.com>
References: <a5054dfad3d48c582b062b0536125c9bcff41f31.1438027526.git.hramrach@gmail.com>
 <e1952e8c102a3b7a7f3f79c759c44093e0d11dc7.1438073049.git.hramrach@gmail.com>
Message-ID: <041501d0c999$8af92f30$a0eb8d90$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal Suchanek wrote:
> 
> Although there is only one choice of chipselect it is necessary to
> specify it. The driver cannot claim the gpio otherwise.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> Acked-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

>From here ---8<--------8<-----------

> --
>  - don't move unrelated line
>  - use symbolic GPIO_ACTIVE_HIGH

to here  ---8<--------8<-----------

should be added under the following '---'.

Please add some additional comments like above 'changes since previous version'
under the following '---' not '--', because all comments will be logged before
the '---' and I don't want to keep the changes basically.

Anyway, applied with removing above comments.

Thanks,
Kukjin

> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index b7f4122..2d6a976 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -688,6 +688,7 @@
>  	status = "okay";
>  	samsung,spi-src-clk = <0>;
>  	num-cs = <1>;
> +	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
>  };
> 
>  &usbdrd_dwc3 {
> --
> 2.1.4
