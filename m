From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Oct 2014 20:24:27 +0200
Subject: [PATCH] ARM: dts: rockchip: enable DMA on SPI for rk3066 and
 rk3188
In-Reply-To: <1412928253-5119-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1412928253-5119-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <4669230.PsEI42KPZh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Am Freitag, 10. Oktober 2014, 10:04:13 schrieb Julien CHAUVEAU:
> According to the RK3066 and RK3188 TRM, the two SPI controllers support DMA
> handshake interface. Add the DMA properties so they can be used when needed.
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

added the patch to a temporary branch for 3.19
(on github and will move to kernel.org once 3.18-rc1 is released)


Heiko

> ---
>  arch/arm/boot/dts/rk3xxx.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 499468d..9ba92de 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -367,6 +367,8 @@
>  		reg = <0x20070000 0x1000>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		dmas = <&dmac2 10>, <&dmac2 11>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
> 
> @@ -378,6 +380,8 @@
>  		reg = <0x20074000 0x1000>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		dmas = <&dmac2 12>, <&dmac2 13>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  };
