From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Jun 2018 10:07:58 -0700
Subject: [PATCH v8 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <1527122121-31452-2-git-send-email-rishabhb@codeaurora.org>
References: <1527122121-31452-1-git-send-email-rishabhb@codeaurora.org>
 <1527122121-31452-2-git-send-email-rishabhb@codeaurora.org>
Message-ID: <20180622170758.GH10336@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 May 17:35 PDT 2018, Rishabh Bhatnagar wrote:

> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..5e85749
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,26 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
> +that can be shared by multiple clients. Clients here are different cores in the
> +SOC, the idea is to minimize the local caches at the clients and migrate to
> +common pool of memory. Cache memory is divided into partitions called slices
> +which are assigned to clients. Clients can query the slice details, activate
> +and deactivate them.
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +	Usage: required
> +	Value Type: <prop-encoded-array>
> +	Definition: Start address and the the size of the register region.
> +
> +Example:
> +
> +	cache-controller at 1100000 {
> +		compatible = "qcom,sdm845-llcc";
> +		reg = <0x1100000 0x250000>;
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
