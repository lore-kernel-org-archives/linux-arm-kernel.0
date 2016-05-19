From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 19 May 2016 17:51:54 +0200
Subject: [PATCH 1/3] spi/rockchip: add rk3036/rk3228/rk3368 socs for spi
 document
In-Reply-To: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
References: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
Message-ID: <3685935.dKdIbE8hXb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 19. Mai 2016, 23:47:02 schrieb Caesar Wang:
> We had supported the rk3036/rk3066/rk3188/rk3228/rk3288/rk3368/rk3399
> family SoCs in linux kernel.
> 
> Let's add the other SoCs, in order to a better understanding from the
> rockchip spi document.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> ---
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> b/Documentation/devicetree/bindings/spi/spi-rockchip.txt index
> 1b14d69..305b542 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> @@ -6,9 +6,12 @@ and display controllers using the SPI communication
> interface. Required Properties:
> 
>  - compatible: should be one of the following.
> +    "rockchip,rk3036-spi" for rk3036.

shouldn't the rk3036 also get the rk3066 fallback. Looking at the driver 
part (patch2) the rk3036 still is the same IP as for every other soc in 
here.

>      "rockchip,rk3066-spi" for rk3066.
>      "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
> +    "rockchip,rk3228-spi", "rockchip,rk3066-spi" for rk3228.
>      "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
> +    "rockchip,rk3368-spi", "rockchip,rk3066-spi" for rk3368.
>      "rockchip,rk3399-spi", "rockchip,rk3066-spi" for rk3399.
>  - reg: physical base address of the controller and length of memory
> mapped region.
