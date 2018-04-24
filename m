From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 11:15:21 -0500
Subject: [PATCH v5 05/23] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
In-Reply-To: <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
Message-ID: <20180424161521.tyhnpiwbz2tqqetj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 04:31:39PM +0100, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

Similar comments in this one.

> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> new file mode 100644
> index 000000000000..f1e2df8d2ea8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Device Manager (Q6ADM) binding
> +
> +Q6ADM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
> +used by the apr service device.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		   Or "qcom,adm" where the version number can be queried
> +		   from DSP.
> +		   example "qcom,adm-v2.0"
> +
> +
> += ADM routing
> +"routing" subnode of the ADM node represents adm routing specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Must be 0
> +
> += EXAMPLE
> +q6adm {

a6adm@?

Needs to be the number, not a define.

> +	compatible = "qcom,q6adm";
> +	reg = <APR_SVC_ADM>;
> +	q6routing: routing {
> +		#sound-dai-cells = <0>;
> +	};
> +};
> -- 
> 2.16.2
> 
