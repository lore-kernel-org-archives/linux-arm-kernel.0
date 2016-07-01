From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 1 Jul 2016 11:00:28 +0100
Subject: [PATCH v2 5/6] documentation: Add nvmem bindings documentation
In-Reply-To: <1467203656-14381-6-git-send-email-carlo@caione.org>
References: <1467203656-14381-1-git-send-email-carlo@caione.org>
 <1467203656-14381-6-git-send-email-carlo@caione.org>
Message-ID: <57763F3C.7090108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/06/16 13:34, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> This patch add the bindings document of Amlogic eFuse driver.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   .../devicetree/bindings/nvmem/amlogic-efuse.txt    | 39 ++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> new file mode 100644
> index 0000000..fafd85b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> @@ -0,0 +1,39 @@
> += Amlogic eFuse device tree bindings =
> +
> +Required properties:
> +- compatible: should be "amlogic,meson-gxbb-efuse"
> +
> += Data cells =
> +Are child nodes of eFuse, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	efuse: efuse {
> +		compatible = "amlogic,meson-gxbb-efuse";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sn: sn at 14 {
> +			reg = <0x14 0x10>;
> +		};
> +
> +		eth_mac: eth_mac at 34 {
> +			reg = <0x34 0x10>;
> +		};
> +
> +		bid: bid at 46 {
> +			reg = <0x46 0x30>;
> +		};
> +	};
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	eth_mac {
> +		...
> +		nvmem-cells = <&eth_mac>;
> +		nvmem-cell-names = "eth_mac";
> +	};
>
