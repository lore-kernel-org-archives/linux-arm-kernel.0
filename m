From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 30 Jan 2015 08:57:29 +0000
Subject: [PATCH] regulator: qcom-rpm: Make it possible to specify supply
In-Reply-To: <1422577377-31986-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422577377-31986-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <54CB4779.6070107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,
Thanks for sending this patch.. I almost forgot about this.

Shouldn?t we update the DT Bindings with this info?

Other than that:
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

On 30/01/15 00:22, Bjorn Andersson wrote:
> Make it possible to specify the supply of a regulator, through the
> vin-supply property in dt.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>   drivers/regulator/qcom_rpm-regulator.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
> index e3120bf..00c5cc3 100644
> --- a/drivers/regulator/qcom_rpm-regulator.c
> +++ b/drivers/regulator/qcom_rpm-regulator.c
> @@ -679,6 +679,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
>   	vreg->desc.owner = THIS_MODULE;
>   	vreg->desc.type = REGULATOR_VOLTAGE;
>   	vreg->desc.name = pdev->dev.of_node->name;
> +	vreg->desc.supply_name = "vin";
>
>   	vreg->rpm = dev_get_drvdata(pdev->dev.parent);
>   	if (!vreg->rpm) {
>
