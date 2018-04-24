From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 11:17:30 -0500
Subject: [PATCH v5 06/23] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
In-Reply-To: <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
Message-ID: <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 04:31:40PM +0100, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> new file mode 100644
> index 000000000000..d034a50a202a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Stream Manager (Q6ASM) binding
> +
> +Q6ASM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
> +used by the apr service device.

Need to be clear this is a child of APR.

> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		    Or "qcom,asm" where the version number can be queried
> +		    from DSP.
> +		    example "qcom,asm-v2.0"
> +
> += ASM DAIs (Digial Audio Interface)
> +"dais" subnode of the ASM node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Must be 1
> +
> += EXAMPLE
> +
> +q6asm {

Unit address needed.

> +	compatible = "qcom,q6asm";

Doesn't match the doc.

> +	reg = <APR_SVC_ASM>;
> +	q6asmdai: dais {
> +		#sound-dai-cells = <1>;
> +	};
> +};
> diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
> new file mode 100644
> index 000000000000..2e11b15d930d
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6asm.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __DT_BINDINGS_Q6_ASM_H__
> +#define __DT_BINDINGS_Q6_ASM_H__
> +
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
> +
> +#endif /* __DT_BINDINGS_Q6_ASM_H__ */
> -- 
> 2.16.2
> 
