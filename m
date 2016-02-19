From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 19 Feb 2016 11:05:39 +0100
Subject: [PATCH] ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail
 issue
In-Reply-To: <1455861643-24307-1-git-send-email-eddie.huang@mediatek.com>
References: <1455861643-24307-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <56C6E8F3.4020402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

On 19/02/16 07:00, Eddie Huang wrote:
> MT8173 E1 chip has one bug that if turn off USB power domain, vcore
> power will also be off, thus cause modules using vcore power domain
> fail, like MMC. The E1 chip only found on MT8173-evb board and this
> board only has E1 chip, so implement this as a board specific
> workaround.
>
> Pwrapper use vcore power, so add pwrapper using USB power domain to
> keep USB power domain not to zero and disabled.
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>
> ---
> Sascha sent similar patch before[0], but MMC support runtime-pm,
> vcore power domain still be disabled after MMC and USB suspend.
> This silicon bug already fix in MT8173 MP chip.
>
> [0]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358065.html
> ---
>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index e427f04..7453a47 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -214,6 +214,9 @@
>   };
>
>   &pwrap {
> +	/* Only MT8173 E1 needs USB power domain */
> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
> +

Applied, thanks
