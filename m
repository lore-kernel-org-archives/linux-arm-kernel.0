From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Jan 2014 10:03:45 -0800
Subject: [PATCH v2 6/7] mfd: pm8921: Add DT match table
In-Reply-To: <20140106115249.GD30156@lee--X1>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-7-git-send-email-sboyd@codeaurora.org>
 <20140106115249.GD30156@lee--X1>
Message-ID: <52CAF001.30501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/14 03:52, Lee Jones wrote:
>> Allow this driver to probe based on devicetree.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/mfd/pm8921-core.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
>> index d13cb6e..290f0da 100644
>> --- a/drivers/mfd/pm8921-core.c
>> +++ b/drivers/mfd/pm8921-core.c
>> @@ -420,6 +420,13 @@ static const struct regmap_config ssbi_regmap_config = {
>>  	.reg_write = ssbi_reg_write
>>  };
>>  
>> +static const struct of_device_id pm8921_id_table[] = {
>> +	{ .compatible = "qcom,pm8058", },
>> +	{ .compatible = "qcom,pm8921", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pm8921_id_table);
>> +
>>  static int pm8921_probe(struct platform_device *pdev)
>>  {
>>  	struct pm8921 *pmic;
>> @@ -429,7 +436,6 @@ static int pm8921_probe(struct platform_device *pdev)
>>  	unsigned int irq;
>>  	u32 rev;
>>  
>> -
> Sneaky!

Sorry, I messed up this patch. This removal is supposed to be in an
earlier patch. Fixed now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
