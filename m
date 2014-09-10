From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Sep 2014 11:51:21 -0700
Subject: [PATCH] ARM: perf: Don't sleep while atomic when enabling per-cpu
 interrupts
In-Reply-To: <20140910182137.GL1710@arm.com>
References: <1410200814-25878-1-git-send-email-sboyd@codeaurora.org>
 <20140909113943.GG1754@arm.com> <540F3EE5.90500@codeaurora.org>
 <20140910182137.GL1710@arm.com>
Message-ID: <54109DA9.4070208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/14 11:21, Will Deacon wrote:
> On Tue, Sep 09, 2014 at 06:54:45PM +0100, Stephen Boyd wrote:
>
>> Here's the interdiff. Is there a reason arm64 casts data to an unsigned
>> int pointer when what's passed is an int pointer?
> There has to be a cast to something because data is a void *.
> enable_percpu_irq takes an unsigned int, so I guess that's why it was
> chosen. I'm not fussed either way.

Right, I'm just annoyed that what's passed in the void * is not an
unsigned int, it's an int. I agree that eventually we'll hand it to
enable_percpu_irq and there it will be implicitly casted to an unsigned
int so it really doesn't matter.

>
> Feel free to submit the full patch with my ack:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>

Ok thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
