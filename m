From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Nov 2016 10:40:45 -0800
Subject: [PATCH v2 1/2] mfd: pm8xxx: add support to pm8821
In-Reply-To: <1479145933-9849-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479145933-9849-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <a1116e3f-32d2-aa2d-9404-1d8147bd8500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2016 09:52 AM, Srinivas Kandagatla wrote:
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 7f9620e..dc347d3 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> +
> +static void pm8821_irq_handler(struct irq_desc *desc)
> +{
> +	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
> +	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
> +	unsigned int master;
> +	int ret;
> +
> +	chained_irq_enter(irq_chip, desc);
> +	ret = regmap_read(chip->regmap,
> +			  PM8821_SSBI_REG_ADDR_IRQ_MASTER0, &master);
> +	if (ret) {
> +		pr_err("Failed to re:Qad master 0 ret=%d\n", ret);

Hm? vi?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
