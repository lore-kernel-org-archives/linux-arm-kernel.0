From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 10 Apr 2013 09:12:04 -0400
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <20130410114126.GB26992@mudshark.cambridge.arm.com>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
 <1365510814-21343-1-git-send-email-cov@codeaurora.org>
 <20130410114126.GB26992@mudshark.cambridge.arm.com>
Message-ID: <51656524.10708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 04/10/2013 07:41 AM, Will Deacon wrote:
> On Tue, Apr 09, 2013 at 01:33:34PM +0100, Christopher Covington wrote:
>> For accurate accounting pass contextidr_thread_switch the prev
>> task pointer, since cpu_switch_to has at that point changed the
>> the stack pointer.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> 
> Thanks Christopher -- I assume that using prev did resolve your issues?

Yes indeed. We're now able to see in simulation that if a userspace process
uses 100% CPU, its thread ID, rather than what was usually some random
kthread, gets written out most of the time. I donno if that meets your
criteria for a "real" use case, but I hope it's at least sufficient testing of
the code for now.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
