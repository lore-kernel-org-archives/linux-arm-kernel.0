From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 03 Nov 2014 08:27:46 +0800
Subject: [PATCH 2/2] regulator: of: Add support for parsing microvolts
 for suspend state
In-Reply-To: <54549EA6.5060007@collabora.co.uk>
References: <1414813978-32233-1-git-send-email-dianders@chromium.org>
 <1414813978-32233-2-git-send-email-dianders@chromium.org>
 <54549EA6.5060007@collabora.co.uk>
Message-ID: <5456CC02.1060201@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/01/2014 04:49 PM, Javier Martinez Canillas wrote:
> Hello Doug,
>
> On 11/01/2014 04:52 AM, Doug Anderson wrote:
>> Leverage all the work that was done in (40e20d6 regulator: of: Add
>> support for parsing regulator_state for suspend state) and throw in
>> the ability to set suspend microvolts from the device tree.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>   drivers/regulator/of_regulator.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
>> index f0d19fc..7fe93c5 100644
>> --- a/drivers/regulator/of_regulator.c
>> +++ b/drivers/regulator/of_regulator.c
>> @@ -107,6 +107,10 @@ static void of_get_regulation_constraints(struct device_node *np,
>>   					"regulator-off-in-suspend"))
>>   			suspend_state->disabled = true;
>>   
>> +		if (!of_property_read_u32(suspend_np,
>> +					"regulator-suspend-microvolt", &pval))
>> +			suspend_state->uV = pval;
>> +
>>   		of_node_put(suspend_np);
>>   		suspend_state = NULL;
>>   		suspend_np = NULL;
>>
> Looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> Best regards,
> Javier
>
>
>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
