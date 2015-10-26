From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 26 Oct 2015 09:56:14 +0000
Subject: [PATCH 1/3] dt-bindings: add document of mediatek efuse driver
In-Reply-To: <1444984751-4572-2-git-send-email-andrew-ct.chen@mediatek.com>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
 <1444984751-4572-2-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <562DF8BE.4060205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/10/15 09:39, andrew-ct.chen at mediatek.com wrote:
> From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>
> Add Mediatek MT8173 EFUSE Devicetree binding file
>
> Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Looks good to me, minor comment below.

Will queue this for v4.5 once v4.4-rc1 is released.


> ---
>   .../devicetree/bindings/nvmem/mtk-efuse.txt        | 36 ++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> new file mode 100644
> index 0000000..92edc3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> @@ -0,0 +1,36 @@
> += Mediatek MTK-EFUSE device tree bindings =
> +
> +This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
> +
> +Required properties:
> +- compatible: should be "mediatek,mt8173-efuse" or "mediatek,mt8135-efuse"

Can we make the compatible more generic for mediatek socs? Like 
"mediatek,efuse"  Or are they different in each SOC?

--srini
> +- reg: Should contain registers location and length
> +
> += Data cells =
> +Are child nodes of MTK-EFUSE, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	efuse: efuse at 10206000 {
> +		compatible = "mediatek,mt8173-efuse";
> +		reg	   = <0 0x10206000 0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		/* Data cells */
> +		thermal_calibration: calib at 528 {
> +			reg = <0x528 0xc>;
> +		};
> +	};
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	thermal {
> +		...
> +		nvmem-cells = <&thermal_calibration>;
> +		nvmem-cell-names = "calibration";
> +	};
>
