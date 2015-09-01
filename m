From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Sep 2015 13:30:19 -0700
Subject: [PATCH 2/3] soc: qcom: smd: Use __iowrite32_copy() instead of
 open-coding it
In-Reply-To: <20150901180353.GB19120@codeaurora.org>
References: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
 <1441071594-15941-3-git-send-email-sboyd@codeaurora.org>
 <20150901045945.GC13472@usrtlx11787.corpusers.net>
 <20150901180353.GB19120@codeaurora.org>
Message-ID: <55E60ADB.8050704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2015 11:03 AM, Stephen Boyd wrote:
> On 08/31, Bjorn Andersson wrote:
>> On Mon 31 Aug 18:39 PDT 2015, Stephen Boyd wrote:
>>
>>> We already have a function to do this and it silences some sparse
>>> warnings along the way.
>>>
>> Didn't know that, thanks. Do you know why there's no equivalent for
>> transfers in the other direction? Should we hack one up to do the same
>> simplification in smd_copy_from_fifo()?
> Don't know. We can certainly write one although it would be nice
> if we had two users. I'll take a look.
>

Looks like we can convert smd and bcm47xx_nvram over. Also, we need to
add it or move the readl_relaxed() to a __raw_readl() in
smd_copy_from_fifo() because it's doing byte swapping that we don't want.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
