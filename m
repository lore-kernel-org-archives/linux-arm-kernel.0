From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Nov 2016 14:16:39 +0000
Subject: [RFC PATCH] of: base: add support to get machine model name
In-Reply-To: <2202339.ajrKjCY7Ro@wuerfel>
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
 <3670336.mMHByOpDl4@wuerfel> <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
 <2202339.ajrKjCY7Ro@wuerfel>
Message-ID: <d4839046-49f6-b375-fc64-acf64b450540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/16 14:13, Arnd Bergmann wrote:
> On Thursday, November 17, 2016 2:08:30 PM CET Sudeep Holla wrote:
>> On 17/11/16 13:50, Arnd Bergmann wrote:
>>> On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
>>>> Currently platforms/drivers needing to get the machine model name are
>>>> replicating the same snippet of code. In some case, the OF reference
>>>> counting is either missing or incorrect.
>>>>
>>>> This patch adds support to read the machine model name either using
>>>> the "model" or the "compatible" property in the device tree root node.
>>>>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> I like the idea. One small comment:
>>>
>>
>> Thanks. I prefer it as single patch but it can't be applied to any tree.
>> Any suggestions on handling this patch to fix the warning in -next ?
>>
> The patch that causes the warning is currently in the mmc tree, and I
> don't think it would be good to have your entire patch in there too.
>
> It's probably best to just fix the warning there now by adding another
> open-coded copy of that function, and then apply your patch on top
> for v4.11.

Sure, that's much simpler to deal with for now.

-- 
Regards,
Sudeep
