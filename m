From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jul 2017 14:02:35 -0700
Subject: [PATCH 1/2] pinctrl: qcom: spmi-gpio: Add pmi8994 gpio support
In-Reply-To: <1501137036-20155-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501137036-20155-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <15907d20-c0a5-1825-ea5f-56eb13df746b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2017 11:30 PM, Vivek Gautam wrote:
> Update the bindings doc and driver for pmi8994-gpio devices.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>
> - Have been using this patch-set on db820c [1] for extcon with
>   usb controller. The usb controller uses one of these gpios
>   for usb-id/vbus detection.
>
> [1] https://github.com/boddob/linux/tree/for-qcomlt/4.13rc2-merged
>
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index 8d893a874634..74932318d41d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -15,6 +15,7 @@ PMIC's from Qualcomm.
>  		    "qcom,pm8921-gpio"
>  		    "qcom,pm8941-gpio"
>  		    "qcom,pm8994-gpio"
> +		    "qcom,pmi8994-gpio"

pmi comes after pma. Please sort alphabetically.

>  		    "qcom,pma8084-gpio"
>  
>  		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
> @@ -84,6 +85,7 @@ to specify in a pin configuration subnode:
>  		    gpio1-gpio44 for pm8921
>  		    gpio1-gpio36 for pm8941
>  		    gpio1-gpio22 for pm8994
> +		    gpio1-gpio10 for pmi8994
>  		    gpio1-gpio22 for pma8084
>  
>  - function:
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 664b641fd776..bf0a6438424b 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -799,6 +799,7 @@ static int pmic_gpio_remove(struct platform_device *pdev)
>  	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
>  	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
>  	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> +	{ .compatible = "qcom,pmi8994-gpio" },	/* 10 GPIO's */

As stated on the other patch, please drop this hunk.

>  	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
>  	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
>  	{ },


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
