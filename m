From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 23 Sep 2015 10:23:58 -0700
Subject: [Patch v2 06/10] regulators: qcom-smd: Add PM8916 support
In-Reply-To: <1443027209-19444-7-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
 <1443027209-19444-7-git-send-email-agross@codeaurora.org>
Message-ID: <20150923172358.GE24668@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Sep 09:53 PDT 2015, Andy Gross wrote:

> This patch adds support and documentation for the PM8916 regulators
> found on MSM8916 platforms.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |   18 ++++++
>  drivers/regulator/qcom_smd-regulator.c             |   64 ++++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
> index 7084474..05dfc1a 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
> @@ -18,6 +18,7 @@ Regulator nodes are identified by their compatible:
>  	Definition: must be one of:
>  		    "qcom,rpm-pm8841-regulators"
>  		    "qcom,rpm-pm8941-regulators"
> +		    "qcom,rpm-pm8916-regulators"

Alphabetical please

>  
>  - vdd_s1-supply:
>  - vdd_s2-supply:
> @@ -50,6 +51,19 @@ Regulator nodes are identified by their compatible:
>  	Definition: reference to regulator supplying the input pin, as
>  		    described in the data sheet
>  
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_s4-supply:
> +- vdd_l1_l2_l3-supply
> +- vdd_l4_l5_l6-supply
> +- vdd_l7-supply

End these with ':' as well

> +- vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18-supply:
> +	Usage: optional (pm8916 only)
> +	Value type: <phandle>
> +	Definition: reference to regulator supplying the input pin, as
> +		    described in the data sheet
> +
[..]
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
[..]
>  static const struct of_device_id rpm_of_match[] = {
> +	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },

pm8916 > pm8841

>  	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
>  	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
>  	{}

With these nits:

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
