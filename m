From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 14 May 2017 01:16:03 +0900
Subject: [PATCH] arm64: dts: uniphier: add cdns,
 phy-dll-delay-sdclk(-hsmmc) for eMMC
In-Reply-To: <1491271477-19806-1-git-send-email-yamada.masahiro@socionext.com>
References: <1491271477-19806-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARmTXLsyx1bDQLYkHr-QqcFf+Lth5D+X3VoasEy0MWYMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-04 11:04 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Adjust the PHY parameters for more stable access to the eMMC device.
> Set the SDCLK output delay value to 21 (including HS200/400 modes).
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 ++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 42f1803..25a525c 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -313,6 +313,8 @@
>                         cdns,phy-input-delay-legacy = <4>;
>                         cdns,phy-input-delay-mmc-highspeed = <2>;
>                         cdns,phy-input-delay-mmc-ddr = <3>;
> +                       cdns,phy-dll-delay-sdclk = <21>;
> +                       cdns,phy-dll-delay-sdclk-hsmmc = <21>;
>                 };
>
>                 usb0: usb at 5a800100 {
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index e4499ff..c85e6e2 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -387,6 +387,8 @@
>                         cdns,phy-input-delay-legacy = <4>;
>                         cdns,phy-input-delay-mmc-highspeed = <2>;
>                         cdns,phy-input-delay-mmc-ddr = <3>;
> +                       cdns,phy-dll-delay-sdclk = <21>;
> +                       cdns,phy-dll-delay-sdclk-hsmmc = <21>;
>                 };
>
>                 soc-glue at 5f800000 {


Applied to linux-uniphier.



-- 
Best Regards
Masahiro Yamada
