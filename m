From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 16 May 2018 10:03:33 -0700
Subject: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
Message-ID: <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..a586a17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,32 @@
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
> +       Usage: required
> +       Value type: <string>
> +       Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +       Usage: required
> +       Value Type: <prop-encoded-array>
> +       Definition: Start address and the range of the LLCC registers.

Start address and size?

> +
> +- max-slices:
> +       usage: required
> +       Value Type: <u32>
> +       Definition: Number of cache slices supported by hardware
> +
> +Example:
> +
> +       llcc: qcom,llcc at 1100000 {

cache-controller at 1100000 ?

> +               compatible = "qcom,sdm845-llcc";
> +               reg = <0x1100000 0x250000>;
> +               max-slices = <32>;
> +       };
> -- 
