From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Jul 2015 11:07:42 -0700
Subject: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
In-Reply-To: <20150708110005.704c49ff@bbrezillon>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>	<20150708005748.GG30412@codeaurora.org>
 <20150708110005.704c49ff@bbrezillon>
Message-ID: <559D66EE.4060707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2015 02:00 AM, Boris Brezillon wrote:
> Hi Stephen,
>
> On Tue, 7 Jul 2015 17:57:48 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> On 07/07, Boris Brezillon wrote:
>>>
>>>  	} else {
>>>  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
>>> +		req->rate = 0;
>>>  		return 0;
>> Shouldn't this return an error now? And then assigning req->rate
>> wouldn't be necessary. Sorry I must have missed this last round.
>>
> Actually I wanted to keep the existing behavior: return a 0 rate (not
> an error) when there is no mux or rate ops.
>
> That's something we can change afterwards, but it might reveals
> new bugs if some users are checking for a 0 rate to detect errors.
>

Ok. Care to send the patch now to do that while we're thinking about it?
We can test it out for a month or two.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
