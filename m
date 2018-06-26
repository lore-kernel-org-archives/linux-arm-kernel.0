From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 26 Jun 2018 11:28:59 +0200
Subject: [PATCH v2 03/12] ASoC: q6afe: dt-bindings: add compatible string
 to dais
In-Reply-To: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
Message-ID: <20180626092859.GA25217@centauri.ideon.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:07AM +0100, Srinivas Kandagatla wrote:
> Add compatible string to dais so that it can support DT based module
> autoloading.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> index bdbf87df8c0b..a8179409c194 100644
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
> @@ -100,6 +105,7 @@ q6afe at 4 {
>  	reg = <APR_SVC_AFE>;
>  
>  	dais {
> +		compatible = "qcom,q6afe-dais";
>  		#sound-dai-cells = <1>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.16.2
> 
