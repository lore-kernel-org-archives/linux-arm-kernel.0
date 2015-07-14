From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Jul 2015 17:59:10 -0700
Subject: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
In-Reply-To: <55A45EAA.9040001@codeaurora.org>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
 <20150714002504.GC7945@dtor-ws> <55A45931.4010509@codeaurora.org>
 <20150714004638.GD7945@dtor-ws> <55A45EAA.9040001@codeaurora.org>
Message-ID: <55A45EDE.6050603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 05:58 PM, Stephen Boyd wrote:
> On 07/13/2015 05:46 PM, Dmitry Torokhov wrote:
>> On Mon, Jul 13, 2015 at 05:34:57PM -0700, Stephen Boyd wrote:
>>> On 07/13/2015 05:25 PM, Dmitry Torokhov wrote:
>>>>> +
>>>>> +static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
>>>>> +    { .compatible = "qcom,pm8058-pwrkey", .data = 
>>>>> &pm8058_pwrkey_shutdown },
>>>>> +    { .compatible = "qcom,pm8921-pwrkey", .data = 
>>>>> &pm8921_pwrkey_shutdown },
>>>>> +    { }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
>>>>> +
>>>> Can we please keep IDs and device table where it was, close to the
>>>> driver definition?
>>> That would require forward declaring the array here. Is that
>>> desired? I moved it so that I could use it in the probe function.
>> Ah, yes, OF data is not passed into probe() :(... But we can always do:
>>
>>     match = of_match_device(pdev->dev.driver->of_match_table, 
>> &pdev->dev);
>>
>> Maybe we could have a helper for this like:
>>
>> const struct of_device_id *of_get_current_match(struct device *dev)
>> {
>>     return dev->drv ?
>>         of_match_device(dev->driver->of_match_table, dev) :
>>         NULL;
>> }
>
> Nice. I'll update and Cc the OF maintainers.
>

Actually, this already exists I just didn't know. See 
of_device_get_match_data().

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
