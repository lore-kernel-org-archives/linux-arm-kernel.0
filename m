From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 11 May 2016 12:49:05 -0700
Subject: [Patch v4 1/8] dt/bindings: firmware: Add Qualcomm SCM binding
In-Reply-To: <1462976158-26016-2-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
 <1462976158-26016-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20160511194905.GU1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 May 07:15 PDT 2016, Andy Gross wrote:

> This patch adds the device tree support for the Qualcomm SCM firmware.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  .../devicetree/bindings/firmware/qcom,scm.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> new file mode 100644
> index 0000000..0c5f1ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> @@ -0,0 +1,28 @@
> +QCOM Secure Channel Manager (SCM)
> +
> +Qualcomm processors include an interface to communicate to the secure firmware.
> +This interface allows for clients to request different types of actions.  These
> +can include CPU power up/down, HDCP requests, loading of firmware, and other
> +assorted actions.
> +
> +Required properties:
> +- compatible: must contain one of the following:
> + * "qcom,scm-apq8064" for APQ8064 platforms
> + * "qcom,scm-msm8660" for MSM8660 platforms
> + * "qcom,scm-msm8690" for MSM8690 platforms
> + * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
> +- clocks: One to three clocks may be required based on compatible.
> + * Only core clock required for "qcom,scm-apq8084", "qcom,scm-msm8660", and "qcom,scm-msm8960"
> + * Core, iface, and bus clocks required for "qcom,scm"
> +- clock-names: Must contain "core" for the core clock, "iface" for the interface
> +  clock and "bus" for the bus clock per the requirements of the compatible.

I like this split of generic binding and the special cases, gives the
wanted clarity for the outliers without the added churn in the common
case.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
