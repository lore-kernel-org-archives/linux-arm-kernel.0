From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 12 Jan 2017 12:50:44 +0800
Subject: [PATCH v5] arm64: dts: mt8173: add mmsel clocks for 4K support
In-Reply-To: <1470279438-60372-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279438-60372-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <CAGS+omAZvHmSz6bJcvisC1LZgxwbd-HzvYMDrHXzfkY3mZZEsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

(Trying again to send plain text email)...

On Thu, Aug 4, 2016 at 10:57 AM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> To support HDMI 4K resolution, mmsys need clcok
> mm_sel to be 400MHz.
>
> The board .dts file should override the clock rate
> property with the higher VENCPLL frequency the board
> supports HDMI 4K resolution.
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>


It looks like this patch was lost.  It is actually a prerequisite for
MTK 4k HDMI support, which already landed in v4.9.

See the email thread entitled:
[PATCH v5 0/3] MT8173 HDMI 4K support <https://lkml.org/lkml/2016/9/28/893>

Or these three:

0d2200794f0a drm/mediatek: modify the factor to make the pll_rate set
in the 1G-2G range
968253bd7caa drm/mediatek: enhance the HDMI driving current
d542b7c473f0 drm/mediatek: do mtk_hdmi_send_infoframe after HDMI clock enable

-Dan

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 78529e4..c3f32f3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -690,6 +690,8 @@
>                         compatible = "mediatek,mt8173-mmsys", "syscon";
>                         reg = <0 0x14000000 0 0x1000>;
>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +                       assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
> +                       assigned-clock-rates = <400000000>;
>                         #clock-cells = <1>;
>                 };
>
> --
> 1.7.9.5
>
