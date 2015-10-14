From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 14 Oct 2015 15:39:01 +0200
Subject: [PATCH v4 3/3] arm64: dts: mt8173: add timer node
In-Reply-To: <1443798319-45744-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443798319-45744-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <561E5AF5.5020902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/15 17:05, Yingjoe Chen wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
>
> Add device node to enable GPT timer.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

I reapplied this on v4.4-next/arm64


>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index d18ee42..d763803 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -238,6 +238,15 @@
>   			reg = <0 0x10007000 0 0x100>;
>   		};
>
> +		timer: timer at 10008000 {
> +			compatible = "mediatek,mt8173-timer",
> +				     "mediatek,mt6577-timer";
> +			reg = <0 0x10008000 0 0x1000>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_CLK_13M>,
> +				 <&topckgen CLK_TOP_RTC_SEL>;
> +		};
> +
>   		pwrap: pwrap at 1000d000 {
>   			compatible = "mediatek,mt8173-pwrap";
>   			reg = <0 0x1000d000 0 0x1000>;
>
