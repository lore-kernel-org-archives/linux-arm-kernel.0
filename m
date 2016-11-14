From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Nov 2016 19:33:03 +0000
Subject: [PATCH v2 1/2] mfd: pm8xxx: add support to pm8821
In-Reply-To: <a1116e3f-32d2-aa2d-9404-1d8147bd8500@codeaurora.org>
References: <1479145933-9849-1-git-send-email-srinivas.kandagatla@linaro.org>
 <a1116e3f-32d2-aa2d-9404-1d8147bd8500@codeaurora.org>
Message-ID: <0a94fa12-5587-9c89-fc33-1a6f0b20e3a2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/11/16 18:40, Stephen Boyd wrote:
> On 11/14/2016 09:52 AM, Srinivas Kandagatla wrote:
>> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
>> index 7f9620e..dc347d3 100644
>> --- a/drivers/mfd/qcom-pm8xxx.c
>> +++ b/drivers/mfd/qcom-pm8xxx.c
>> +
>> +static void pm8821_irq_handler(struct irq_desc *desc)
>> +{
>> +	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
>> +	unsigned int master;
>> +	int ret;
>> +
>> +	chained_irq_enter(irq_chip, desc);
>> +	ret = regmap_read(chip->regmap,
>> +			  PM8821_SSBI_REG_ADDR_IRQ_MASTER0, &master);
>> +	if (ret) {
>> +		pr_err("Failed to re:Qad master 0 ret=%d\n", ret);
>
> Hm? vi?
yes..  That was good catch!! will fix it in next version...
>
