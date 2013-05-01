From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 01 May 2013 10:44:31 -0400
Subject: [PATCH 6/4] arm64: Move to generic sched_clock infrastructure
In-Reply-To: <20130501091108.GB10984@arm.com>
References: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
 <1367369675-13535-1-git-send-email-sboyd@codeaurora.org>
 <1367369675-13535-2-git-send-email-sboyd@codeaurora.org>
 <20130501091108.GB10984@arm.com>
Message-ID: <51812A4F.7060400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2013 05:11 AM, Catalin Marinas wrote:
> On Wed, May 01, 2013 at 01:54:35AM +0100, Stephen Boyd wrote:
>> Use the generic sched_clock infrastructure instead of rolling our
>> own. This has the added benefit of fixing suspend/resume as
>> outlined in 6a4dae5 (ARM: 7565/1: sched: stop sched_clock()
>> during suspend, 2012-10-23) and correcting the timestamps when
>> the hardware returns a value instead of 0 upon the first read.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Looks ok.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I built and ran this change and dependencies on top of Catalin's
soc-armv8-model branch [1] and was able to verify that it fixed the printk
timestamp jump.

1.
http://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/log/?h=soc-armv8-model

Tested-by: Christopher Covington <cov@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
