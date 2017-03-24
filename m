From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 24 Mar 2017 08:18:14 +0100
Subject: [PATCH v5 1/3] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1489562800-27431-2-git-send-email-yong.mao@mediatek.com>
References: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com>
 <1489562800-27431-2-git-send-email-yong.mao@mediatek.com>
Message-ID: <CAPDyKFpj=xU_-sR_2kPnfmjGLGjWm+Zw1G3mB2naMz09jHJcAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2017 at 08:26, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> Add description for mediatek,hs200-cmd-int-delay
> Add description for mediatek,hs400-cmd-int-delay
> Add description for mediatek,hs400-cmd-resp-sel-rising
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..4182ea3 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,15 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> +                                      If present,HS400 command responses are sampled on rising edges.
> +                                      If not present,HS400 command responses are sampled on falling edges.
>
>  Examples:
>  mmc0: mmc at 11230000 {
> @@ -38,4 +47,7 @@ mmc0: mmc at 11230000 {
>         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>         hs400-ds-delay = <0x14015>;
> +       mediatek,hs200-cmd-int-delay = <26>;
> +       mediatek,hs400-cmd-int-delay = <14>;
> +       mediatek,hs400-cmd-resp-sel-rising;
>  };
> --
> 1.7.9.5
>
