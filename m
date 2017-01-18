From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 15:34:02 -0600
Subject: [PATCH 2/2] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
References: <1484215490-7494-1-git-send-email-yong.mao@mediatek.com>
 <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
Message-ID: <20170118213402.rbduvubbsdpvfgad@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 06:04:50PM +0800, Yong Mao wrote:
> From: yong mao <yong.mao@mediatek.com>
> 
> Add description for hs200-cmd-int-delay
> Add description for hs400-cmd-int-delay
> Add description for cmd-resp-sel
> 
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..2dbb3b0 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,9 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- hs200-cmd-int-delay: HS200 command internal delay setting
> +- hs400-cmd-int-delay: HS400 command internal delay setting

What are the units and range of values? These need vendor prefix as 
well.

> +- cmd-resp-sel: command response sample selection

Looks like a boolean. State that and make the default the more common 
case.

>  
>  Examples:
>  mmc0: mmc at 11230000 {
> @@ -38,4 +41,7 @@ mmc0: mmc at 11230000 {
>  	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>  	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>  	hs400-ds-delay = <0x14015>;
> +	hs200-cmd-int-delay = <26>;
> +	hs400-cmd-int-delay = <14>;
> +	cmd-resp-sel = <0>; /* 0: rising, 1: falling */
>  };
> -- 
> 1.7.9.5
> 
