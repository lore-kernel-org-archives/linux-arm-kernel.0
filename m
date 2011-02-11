From: davidb@codeaurora.org (David Brown)
Date: Fri, 11 Feb 2011 13:03:28 -0800
Subject: [PATCH 2/3] msm: iommu: Generalize platform data for multiple
	targets
In-Reply-To: <4D55A16A.7030300@codeaurora.org> (Steve Muckle's message of
	"Fri, 11 Feb 2011 12:51:54 -0800")
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
	<1297456934.4852.11.camel@m0nster> <4D55A16A.7030300@codeaurora.org>
Message-ID: <8yaipwql1wf.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11 2011, Steve Muckle wrote:

> On 02/11/11 12:42, Daniel Walker wrote:
>>>  static struct resource msm_iommu_jpegd_resources[] = {
>>>  	{
>>> -		.start = MSM_IOMMU_JPEGD_PHYS,
>>> -		.end   = MSM_IOMMU_JPEGD_PHYS + MSM_IOMMU_JPEGD_SIZE - 1,
>>> +		.start = 0x07300000,
>>> +		.end   = 0x07300000 + SZ_1M - 1,
>> 
>> Looks worse .. Just put the macros into a static header file for both.
>
> Why bother defining macros for these if they only appear here? I don't
> think that adds any value or readability - these addresses are clearly
> the physical area for the msm_iommu_jpegd. It just makes it more
> annoying to have to look up the values in a separate file if you are
> wondering what they are.

I want to chime in with a second on this.  Defining names for constants
serves several purposes:

  - It gives meaning to the constants.

  - It allows the definition to be centralized if the value is used in
    one place.

If the constants are initializers in a table, it satisfies both of these
reasons.  Adding #defines for these constants does nothing other than
cause an extra indirection that the reader of the code has to make.

If they were used in more than one place, we could justify the
definition, but in this case, the definition just obscures the code
slightly.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
