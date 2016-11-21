From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 21 Nov 2016 15:51:59 +0100
Subject: [PATCH v6 3/3] arm: dts: mt2701: Add node for Mediatek JPEG
 Decoder
In-Reply-To: <1479353915-5043-4-git-send-email-rick.chang@mediatek.com>
References: <1479353915-5043-1-git-send-email-rick.chang@mediatek.com>
 <1479353915-5043-4-git-send-email-rick.chang@mediatek.com>
Message-ID: <d602365a-e87b-5bae-8698-bd43063ef079@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/16 04:38, Rick Chang wrote:
> Signed-off-by: Rick Chang <rick.chang@mediatek.com>
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> ---
> This patch depends on:
>   CCF "Add clock support for Mediatek MT2701"[1]
>   iommu and smi "Add the dtsi node of iommu and smi for mt2701"[2]
>
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2016-October/007271.html
> [2] https://patchwork.kernel.org/patch/9164013/

I assume that 1 & 2 will appear in 4.10? So this patch needs to go in 
after the
other two are merged in 4.10?

Regards,

	Hans

> ---
>  arch/arm/boot/dts/mt2701.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 8f13c70..4dd5048 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -298,6 +298,20 @@
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
>  	};
>
> +	jpegdec: jpegdec at 15004000 {
> +		compatible = "mediatek,mt2701-jpgdec";
> +		reg = <0 0x15004000 0 0x1000>;
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> +		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> +			  <&imgsys CLK_IMG_JPGDEC>;
> +		clock-names = "jpgdec-smi",
> +			      "jpgdec";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +		mediatek,larb = <&larb2>;
> +		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> +			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> +	};
> +
>  	vdecsys: syscon at 16000000 {
>  		compatible = "mediatek,mt2701-vdecsys", "syscon";
>  		reg = <0 0x16000000 0 0x1000>;
>
