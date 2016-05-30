From: chanho.min@lge.com (Chanho Min)
Date: Tue, 31 May 2016 08:25:27 +0900
Subject: [PATCH] arm64: dts: drop "arm,
 amba-bus" in favor of "simple-bus" part 2
In-Reply-To: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <021901d1baca$8ddf8050$a99e80f0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: [PATCH] arm64: dts: drop "arm,amba-bus" in favor of "simple-bus" part
> 2
> 
> Tree-wide replacement was done by commit 2ef7d5f342c1 (ARM, ARM64:
> dts: drop "arm,amba-bus" in favor of "simple-bus"), but we have some
> new users of "arm,amba-bus" at Linux 4.7-rc1.  Eliminate them now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
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
> b/arch/arm64/boot/dts/lg/lg1312.dtsi
> index 3a4e9a2..fbafa24 100644
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

Acked-by: Chanho Min <chanho.min@lge.com>

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 46f325a..d7f8e06 100644
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
> --
> 1.9.1
