From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Nov 2016 14:08:30 +0000
Subject: [RFC PATCH] of: base: add support to get machine model name
In-Reply-To: <3670336.mMHByOpDl4@wuerfel>
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
 <3670336.mMHByOpDl4@wuerfel>
Message-ID: <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/16 13:50, Arnd Bergmann wrote:
> On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
>> Currently platforms/drivers needing to get the machine model name are
>> replicating the same snippet of code. In some case, the OF reference
>> counting is either missing or incorrect.
>>
>> This patch adds support to read the machine model name either using
>> the "model" or the "compatible" property in the device tree root node.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I like the idea. One small comment:
>

Thanks. I prefer it as single patch but it can't be applied to any tree.
Any suggestions on handling this patch to fix the warning in -next ?

>> +int of_machine_get_model_name(const char **model)
>> +{
>> +	int error;
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return -EINVAL;
>
> The global of_root variable points ot this already, and is defined
> in the same file, so I think we can just skip the lookup.
>

Ah right, will fix it.

-- 
Regards,
Sudeep
