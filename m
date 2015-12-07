From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 7 Dec 2015 12:09:35 +0800
Subject: [PATCH] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1449460394-31601-1-git-send-email-bayi.cheng@mediatek.com>
References: <1449460394-31601-1-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <CAGS+omCuB3VGcPk3fezakdVDnFB3GAmMD+wZ_6nGdv+uHoB40g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bayi,

On Mon, Dec 7, 2015 at 11:53 AM, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
> Add Mediatek nor flash node
>
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> ---
> Previous version of this patch is
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386005.html
> Drop flash node from mt8173.dtsi accroding review comment

Is there a flash on mt8173-evb that can be accessed by the nor_flash ?
If so, can you include flash at 0 node in the mt8173-evb.dts.

-Dan

>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 4dd5f93..af08e97 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -387,6 +387,17 @@
>                         status = "disabled";
>                 };
>
> +               nor_flash: spi at 1100d000 {
> +                       compatible = "mediatek,mt8173-nor";
> +                       reg = <0 0x1100d000 0 0xe0>;
> +                       clocks = <&pericfg CLK_PERI_SPI>,
> +                                <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +                       clock-names = "spi", "sf";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 i2c3: i2c at 11010000 {
>                         compatible = "mediatek,mt8173-i2c";
>                         reg = <0 0x11010000 0 0x70>,
> --
> 1.8.1.1.dirty
>
