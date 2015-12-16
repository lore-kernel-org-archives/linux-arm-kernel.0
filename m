From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 16 Dec 2015 16:34:05 +0800
Subject: [PATCH v5 2/3] arm64: dts: mt8173: Add thermal zone node.
In-Reply-To: <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
 <1450238356-36319-3-git-send-email-dawei.chien@mediatek.com>
Message-ID: <CAGS+omDDfJb9dfWWPaMKs=MkO4Pf3RF9SUD==i7sgHsrDhFDxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 11:59 AM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>
> This adds thermal zone node to Mediatek MT8173 dtsi file.
>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on patchset:
> https://lkml.org/lkml/2015/11/30/239
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index fda805d..4114cee 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -188,6 +188,49 @@
>                 clock-output-names = "cpum_ck";
>         };
>
> +       thermal-zones {
> +               cpu_thermal: cpu_thermal {
> +                       polling-delay-passive = <1000>; /* milliseconds */
> +                       polling-delay = <1000>; /* milliseconds */
> +
> +                       thermal-sensors = <&thermal 0>;

This should be <&thermal> with the MTK temp sensor node in
https://lkml.org/lkml/2015/11/30/239 patch series.

-Dan
