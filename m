From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:47:19 +0200
Subject: [PATCH 4/5] arm: dts: mt7623: add jpeg decoder device node
In-Reply-To: <2f810e9fc20d64d1e673b9ab9abd912d440d071a.1536141302.git.ryder.lee@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
 <2f810e9fc20d64d1e673b9ab9abd912d440d071a.1536141302.git.ryder.lee@mediatek.com>
Message-ID: <08785833-b701-d885-0bf5-6e1bea1d1de1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Add a jpeg decoder device node for MT7623.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index a46987b..d01bdee 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -764,6 +764,21 @@
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
>  	};
>  
> +	jpegdec: jpegdec at 15004000 {
> +		compatible = "mediatek,mt7623-jpgdec",
> +			     "mediatek,mt2701-jpgdec";
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
>  		compatible = "mediatek,mt7623-vdecsys",
>  			     "mediatek,mt2701-vdecsys",
> 
