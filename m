From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 2 Jan 2018 16:35:04 -0800
Subject: [RESEND PATCH v2 01/15] dt-bindings: soc: qcom: Add bindings for
 APR bus
In-Reply-To: <20171214173402.19074-2-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-2-srinivas.kandagatla@linaro.org>
Message-ID: <20180103003504.GX478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add dt bindings for Qualcomm APR bus driver
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> new file mode 100644
> index 000000000000..4e93213ae98d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> @@ -0,0 +1,28 @@
> +Qualcomm APR (Asynchronous Packet Router) binding
> +
> +This binding describes the Qualcomm APR. APR is a IPC protocol for
> +communication between Application processor and QDSP. APR is mainly
> +used for audio/voice services on the QDSP.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apr-<SOC-NAME>" example: "qcom,apr-msm8996"

This is not the only apr on msm8996 and some platform seems to have 3-4
aprs. I'm therefor hesitant to use the compatible to pick the static
list of services available on the particular firmware.

If this scheme is followed we at least would need to rename this
qcom,msm8996-apr-audio-svc

But I think it would be preferable to go with qcom,apr-v2 and then list
the static services as child nodes.

> +
> +
> +- qcom,smd-channel:
> +	Usage: required
> +	Value type: <string>
> +	Definition: standard SMD property specifying the SMD channel used for
> +		    communication with the APR on QDSP.
> +		    Should be "apr_audio_svc".

This is not the only APR channel, but for apr itself this doesn't matter
and might as well be qcom,glink-channels; so perhaps we can omit this
from this document?

> +		    Described in soc/qcom/qcom,smd.txt
> +
> += EXAMPLE
> +The following example represents a QDSP based sound card on a MSM8996 device
> +which uses apr as communication between Apps and QDSP.
> +
> +	apr {
> +		compatible = "qcom,apr-msm8996";
> +		qcom,smd-channels = "apr_audio_svc";
> +	};

Regards,
Bjorn
