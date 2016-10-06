From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 06 Oct 2016 18:33:13 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Enable build of rk3066 MK808 dts
In-Reply-To: <84d4bc0b733cb9776f03ad54bb946fd1c4be4049.1475764778.git.paweljarosz3691@gmail.com>
References: <cover.1475764778.git.paweljarosz3691@gmail.com>
 <84d4bc0b733cb9776f03ad54bb946fd1c4be4049.1475764778.git.paweljarosz3691@gmail.com>
Message-ID: <46121446.zsYkG9qnut@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawe?,

Am Donnerstag, 6. Oktober 2016, 18:22:40 CEST schrieb =?UTF-8?q?
Pawe=C5=82=20Jarosz?=:
> MK808 is rockchip rk3066 based board made by Rickomagic. It has two usb
> ports, sdmmc, wifi and uart onboard.
> 
> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index befcd26..f19cc1d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -639,6 +639,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3036-kylin.dtb \
>  	rk3066a-bqcurie2.dtb \
>  	rk3066a-marsboard.dtb \
> +	rk3066a-mk808.dtb \
>  	rk3066a-rayeager.dtb \
>  	rk3188-radxarock.dtb \
>  	rk3228-evb.dtb \

This patch breaks bisectability, as it adds a dtb to the makefile that you only 
add in patch3 which makes builds fail. Please fold your patches 1 and 3 into 
one patch and also add and entry to Documentation/devicetree/bindings/arm/
rockchip.txt for the board.


Heiko
