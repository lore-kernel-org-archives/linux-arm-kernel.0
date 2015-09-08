From: jteki@openedev.com (Jagan Teki)
Date: Tue, 8 Sep 2015 17:23:32 +0530
Subject: [PATCH 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1441705796-11365-4-git-send-email-bayi.cheng@mediatek.com>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-4-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <CAD6G_RTR2r8ETMQ14uGosRn-85sssvVsFT4BjK9SkVSfMkG8Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2015 at 15:19, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
> Add Mediatek nor flash node
>
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index d18ee42..a14f005 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -365,6 +365,16 @@
>                         status = "disabled";
>                 };
>
> +               nor_flash: nor at 1100d000 {

Based on the comments from 1/3 - this notation needs to be change something like
qspi0: quadspi at 1100d000

> +                       compatible = "mediatek,mt8173-nor";
> +                       reg = <0 0x1100d000 0 0xe0>;
> +                       clocks = <&pericfg CLK_PERI_SPI>,
> +                                <&topckgen CLK_TOP_AXI_SEL>,
> +                                <&topckgen CLK_TOP_UNIVPLL2_D8>,
> +                                <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +                       clock-names = "spi_clk", "axi_clk", "mux_clk", "sf_clk";
> +               };
> +
>                 i2c3: i2c3 at 11010000 {
>                         compatible = "mediatek,mt8173-i2c";
>                         reg = <0 0x11010000 0 0x70>,
> --
> 1.8.1.1.dirty
>

thanks!
-- 
Jagan | openedev.



Sent with MailTrack
