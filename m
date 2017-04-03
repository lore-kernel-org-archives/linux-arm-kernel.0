From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 3 Apr 2017 15:28:43 +0900
Subject: [PATCH] arm64: dts: uniphier: add input-delay properties to
 Cadence eMMC node
In-Reply-To: <1490934045-18874-1-git-send-email-yamada.masahiro@socionext.com>
References: <1490934045-18874-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARtKO-a7tX5U2NGAw707uSLcfxABo1yt44QQfE2go7EmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTD developers,
Please ignore this patch.

I accidentally sent this patch to a wrong ML.
Sorry for the noise.




2017-03-31 13:20 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Since commit a04e2b383401 ("mmc: sdhci-cadence: Update PHY delay
> configuration"), PHY parameters must be specified by DT.
>
> The hard-coded settings have been converted as follows:
> - SDHCI_CDNS_PHY_DLY_SD_DEFAULT -> cdns,phy-input-delay-legacy
> - SDHCI_CDNS_PHY_DLY_EMMC_SDR   -> cdns,phy-input-delay-mmc-highspeed
> - SDHCI_CDNS_PHY_DLY_EMMC_DDR   -> cdns,phy-input-delay-mmc-ddr
>
> The following have not been moved:
> - SDHCI_CDNS_PHY_DLY_SD_HS
>    this is unneeded in the eMMC configuration
> - SDHCI_CDNS_PHY_DLY_EMMC_LEGACY
>    this is never enabled by the driver as it is covered by
>    SDHCI_CDNS_PHY_DLY_SD_DEFAULT
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 +++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 5dc5124..b6ebdc9 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -310,6 +310,9 @@
>                         bus-width = <8>;
>                         mmc-ddr-1_8v;
>                         mmc-hs200-1_8v;
> +                       cdns,phy-input-delay-legacy = <4>;
> +                       cdns,phy-input-delay-mmc-highspeed = <2>;
> +                       cdns,phy-input-delay-mmc-ddr = <3>;
>                 };
>
>                 usb0: usb at 5a800100 {
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index 6c9a72d..0ab6c2e 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -394,6 +394,9 @@
>                         bus-width = <8>;
>                         mmc-ddr-1_8v;
>                         mmc-hs200-1_8v;
> +                       cdns,phy-input-delay-legacy = <4>;
> +                       cdns,phy-input-delay-mmc-highspeed = <2>;
> +                       cdns,phy-input-delay-mmc-ddr = <3>;
>                 };
>
>                 sd: sdhc at 5a400000 {
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
