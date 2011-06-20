From: davidb@codeaurora.org (David Brown)
Date: Mon, 20 Jun 2011 16:27:16 -0700
Subject: [stable] [PATCH v2] msm: timer: compensate for timer shift in
	msm_read_timer_count
In-Reply-To: <20110620215922.GA21909@kroah.com> (Greg KH's message of "Mon, 20
	Jun 2011 14:59:22 -0700")
References: <1308344138-2862-1-git-send-email-johlstei@codeaurora.org>
	<20110620215922.GA21909@kroah.com>
Message-ID: <8ya7h8gozhn.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20 2011, Greg KH wrote:

> On Fri, Jun 17, 2011 at 01:55:38PM -0700, Jeff Ohlstein wrote:
>> Some msm targets have timers whose lower bits are unreliable. So, we
>> present our timers as lower frequency than they actually are, and ignore
>> the bottom 5 bits on such targets. This compensation was erroneously
>> removed from the msm_read_timer_count function, so restore it.
>> 
>> This was broken by 94790ec25 "msm: timer: SMP timer support for msm".
>> 
>> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
>> ---
>>  arch/arm/mach-msm/timer.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>> 
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
>
> </formletter>

I don't think this patch was intended for stable in the first place.
Jeff, this is a fix for 3.0-rcx, right?

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
