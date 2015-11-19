From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Nov 2015 08:47:23 -0600
Subject: [PATCH 2/2] pinctrl: qcom: spmi-mpp: Add pm8994 mpp support
In-Reply-To: <1447807953-11924-3-git-send-email-sboyd@codeaurora.org>
References: <1447807953-11924-1-git-send-email-sboyd@codeaurora.org>
 <1447807953-11924-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151119144723.GA19266@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 04:52:33PM -0800, Stephen Boyd wrote:
> Update the driver and binding for pm8994-mpp devices.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt | 1 +
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
> index d7803a2a94e9..d74e631e10da 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
> @@ -15,6 +15,7 @@ of PMIC's from Qualcomm.
>  		    "qcom,pm8917-mpp",
>  		    "qcom,pm8921-mpp",
>  		    "qcom,pm8941-mpp",
> +		    "qcom,pm8994-mpp",
>  		    "qcom,pma8084-mpp",
>  
>  - reg:
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> index 9ce0e30e33e8..7b4136a22c5b 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
> @@ -907,6 +907,7 @@ static const struct of_device_id pmic_mpp_of_match[] = {
>  	{ .compatible = "qcom,pm8841-mpp" },	/* 4 MPP's */
>  	{ .compatible = "qcom,pm8916-mpp" },	/* 4 MPP's */
>  	{ .compatible = "qcom,pm8941-mpp" },	/* 8 MPP's */
> +	{ .compatible = "qcom,pm8994-mpp" },	/* 8 MPP's */
>  	{ .compatible = "qcom,pma8084-mpp" },	/* 8 MPP's */
>  	{ },
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
