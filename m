From: nleeder@codeaurora.org (Leeder, Neil)
Date: Tue, 25 Jul 2017 15:43:54 -0400
Subject: [PATCH] perf: qcom_l2: fix column exclusion check
In-Reply-To: <20170725170105.GF12749@leverpostej>
References: <1500931022-21000-1-git-send-email-nleeder@codeaurora.org>
 <20170725170105.GF12749@leverpostej>
Message-ID: <95095f56-7b08-4ed9-f7e5-5d5768a75cc5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/25/2017 1:01 PM, Mark Rutland wrote:
> On Mon, Jul 24, 2017 at 05:17:02PM -0400, Neil Leeder wrote:
>> The check for column exclusion did not verify that the event being
>> checked was an L2 event, and not a software event.
>> Software events should not be checked for column exclusion.
>> This resulted in a group with both software and L2 events sometimes
>> incorrectly rejecting the L2 event for column exclusion and
>> not counting it.
>>
>> Add a check for PMU type before applying column exclusion logic.
>>
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> 
> This looks correct, so:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Should this have:
> 
> Fixes: 21bdbb7102edeaeb ("perf: add qcom l2 cache perf events driver")
> 
> ... ?
> 
Thanks. I'll re-post with the Fixes tag.

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
