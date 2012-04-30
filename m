From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 30 Apr 2012 12:30:20 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120426095135.GG17184@pengutronix.de>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org> <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de>
Message-ID: <4F9EE84C.90106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 02:51 AM, Sascha Hauer wrote:
> On Thu, Apr 26, 2012 at 02:36:37AM -0700, Saravana Kannan wrote:
>>
>> On Thu, April 26, 2012 1:42 am, Sascha Hauer wrote:
>>> On Wed, Apr 25, 2012 at 11:28:32PM -0700, Saravana Kannan wrote:
>>>>
>>>>> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
>>>>> index 6e58f11..8e97491 100644
>>>>> --- a/drivers/clk/clk-mux.c
>>>>> +++ b/drivers/clk/clk-mux.c
>>>>> @@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev,
>>>> const char *name,
>>>>>   {
>>>>
>>>> I would really like to remove these functions. At least until we add
>>>> device tree support where each clock is listed in device tree.
>>>>
>>>> At present, these functions seem to be abused more than actually
>>>> being used appropriately.
>>>
>>> I think this goes in my direction. Still exactly this abuse how you call
>>> it makes me relatively independent of for example the changes you
>>> introduce with your patch. Had I static initializers I would now have
>>> to start a rebase orgy.
>>
>> In the other email you say you have to change. Here you say, you don't
>> have to change. Hopefully, you didn't have to change much
>
> I don't have to change much, still there are changes since I also use
> clk_register. I will do the changes if we agree on your patch, but I
> really hope this is the last of such changes.
>
>> -- I was aiming for that.
>
> Thank you for this.
>
>> If there was agreement about removing these functions, I was
>> planning on helping move the current users after this patch merged.
>
> Please understand that I begin to get frustrated. I was really happy to
> see the clock framework merged in the last window. Now it's -rc4 already
> and there are still patches flowing that delay the merge of SoC support.

Mike, Shawn, Paul, Rob,

Comments? Can we pull this in?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
