From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Mon, 25 Jun 2018 20:01:30 +0200
Subject: [PATCH 03/11] ASoC: q6afe: dt-bindings: add compatible string to
 dais
In-Reply-To: <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
Message-ID: <20180625180130.GC10876@centauri.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 03:31:07PM +0100, Srinivas Kandagatla wrote:
> Add compatible string to dais so that it can support DT based module
> autoloading.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> index bdbf87df8c0b..f7ea77ba7947 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> @@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
>  subnode of "dais" representing board specific dai setup.
>  "dais" node should have following properties followed by dai children.
>  
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6afe-dais"
> +
>  - #sound-dai-cells
>  	Usage: required
>  	Value type: <u32>
> @@ -103,6 +108,7 @@ q6afe at 4 {
>  		#sound-dai-cells = <1>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		compatible = "qcom,q6afe-dais";

Perhaps have the compatible before #sound-dai-cells
(and #size-cells, #address-cells) like in two previous
patches.

>  
>  		hdmi at 1 {
>  			reg = <1>;
> -- 
> 2.16.2
> 
