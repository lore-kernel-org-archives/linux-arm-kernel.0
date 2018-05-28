From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 28 May 2018 18:24:35 +0200
Subject: [PATCH 09/12] ARM: dts: exynos5250: add mipi-phy node
In-Reply-To: <1527500833-16005-10-git-send-email-m.purski@samsung.com>
References: <CGME20180528094729eucas1p1cc26ea191a4ee1ba9daa06fae93037bf@eucas1p1.samsung.com>
 <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <1527500833-16005-10-git-send-email-m.purski@samsung.com>
Message-ID: <CAJKOXPe0gq8U+7xSaxaZFjsGxx7iRGKMEtYn==fAZajJkfasxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:47 AM, Maciej Purski <m.purski@samsung.com> wrote:
> The patch adds phy node, required by MIPI devices.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

This have pretty small changes since original Andrzej's patch so
probably Andrzej's authorship should be preserved.

> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 2daf505..a63b655 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -733,6 +733,12 @@
>                         #phy-cells = <0>;
>                 };
>
> +               mipi_phy: video-phy at 10040710 {
> +                       compatible = "samsung,s5pv210-mipi-video-phy";

No DTC warnings (make dtbs W=1)? reg is missing so DTC should complain.

Best regards,
Krzysztof

> +                       #phy-cells = <1>;
> +                       syscon = <&pmu_system_controller>;
> +               };
> +
>                 adc: adc at 12d10000 {
>                         compatible = "samsung,exynos-adc-v1";
>                         reg = <0x12D10000 0x100>;
> --
> 2.7.4
>
