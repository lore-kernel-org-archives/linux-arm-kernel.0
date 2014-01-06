From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Jan 2014 14:26:06 -0800
Subject: [PATCH v2 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <20140106115021.GC30156@lee--X1>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
 <20131224125443.GC30815@sirena.org.uk>
 <20131226194133.GJ31766@codeaurora.org> <20140106115021.GC30156@lee--X1>
Message-ID: <52CB2D7E.7070505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/14 03:50, Lee Jones wrote:
> On Thu, 26 Dec 2013, Stephen Boyd wrote:
>
>> On 12/24, Mark Brown wrote:
>>> On Mon, Dec 23, 2013 at 12:46:00PM -0800, Stephen Boyd wrote:
>>>
>>>> +int ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
>>>> +{
>>>> +	*val = 0;
>>>> +	return ssbi_read(context, reg, (u8 *)val, 1);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(ssbi_reg_read);
>>>> +
>>>> +int ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
>>>> +{
>>>> +	return ssbi_write(context, reg, (u8 *)&val, 1);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(ssbi_reg_write);
>>> Not a big deal but could these just be inlined in the headers?
>> Sure, I can do that if I need to resend? The only benefit I see
>> is two less symbols exported.
> Yes please. After this review.
>

Ok done. Just waiting for you to reply on patch 3 until I resend.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
