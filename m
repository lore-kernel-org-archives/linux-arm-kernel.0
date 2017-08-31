From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Aug 2017 14:52:39 -0500
Subject: [PATCH v3 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
In-Reply-To: <1503642753-12385-3-git-send-email-chen.zhong@mediatek.com>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <1503642753-12385-3-git-send-email-chen.zhong@mediatek.com>
Message-ID: <20170831195239.b2litxbu7smhkkjl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 02:32:30PM +0800, Chen Zhong wrote:
> This patch adds the device tree binding documentation for the MediaTek
> pmic keys found on PMIC MT6397/MT6323.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> new file mode 100644
> index 0000000..100ec44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> @@ -0,0 +1,38 @@
> +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> +
> +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> +and homekey. The key functions are defined as the subnode of the function
> +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> +of Muti-Function Device (MFD)
> +
> +For MT6397/MT6323 MFD bindings see:
> +Documentation/devicetree/bindings/mfd/mt6397.txt
> +
> +Required properties:
> +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> +- linux,keycodes: Specifies the numeric keycode values to
> +	be used for reporting keys presses. The array can
> +	contain up to 2 entries.
> +
> +Optional Properties:
> +- wakeup-source: each key can be used as a wakeup source.

wakeup-source is defined as a boolean.

> +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> +	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> +- debounce-interval: Long press key shutdown debouncing interval time
> +	in seconds. 0/1/2/3 for 8/11/14/5 seconds. If not specified defaults to 0.
> +
> +Example:
> +
> +	pmic: mt6397 {
> +		compatible = "mediatek,mt6397";
> +
> +		...
> +
> +		mt6397keys: mt6397keys {
> +			compatible = "mediatek,mt6397-keys";
> +			linux,keycodes = <KEY_POWER>, <KEY_VOLUMEDOWN>;
> +			wakeup-source = <1>, <0>;
> +			mediatek,long-press-mode = <1>;
> +			debounce-interval = <0>;
> +		};
> +	};
> -- 
> 1.7.9.5
> 
