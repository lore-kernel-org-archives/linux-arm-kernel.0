From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 30 May 2016 12:19:21 +0200
Subject: [PATCH] arm64: dts: drop "arm,
 amba-bus" in favor of "simple-bus" part 2
In-Reply-To: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <3072536.5uGCiTBfGN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 30. Mai 2016, 11:12:33 schrieb Masahiro Yamada:
> Tree-wide replacement was done by commit 2ef7d5f342c1 (ARM, ARM64:
> dts: drop "arm,amba-bus" in favor of "simple-bus"), but we have some
> new users of "arm,amba-bus" at Linux 4.7-rc1.  Eliminate them now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

For the Rockchip part,
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> In order to not leave these compatible strings for the release,
> is it OK to apply this patch for Linux 4.7 ?
> 
> 
> 
>  arch/arm64/boot/dts/lg/lg1312.dtsi       | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi
> b/arch/arm64/boot/dts/lg/lg1312.dtsi index 3a4e9a2..fbafa24 100644
> --- a/arch/arm64/boot/dts/lg/lg1312.dtsi
> +++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
> @@ -125,7 +125,7 @@
>  		#size-cells = <1>;
>  		#interrupts-cells = <3>;
> 
> -		compatible = "arm,amba-bus";
> +		compatible = "simple-bus";
>  		interrupt-parent = <&gic>;
>  		ranges;
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 46f325a..d7f8e06 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -163,7 +163,7 @@
>  	};
> 
>  	amba {
> -		compatible = "arm,amba-bus";
> +		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
