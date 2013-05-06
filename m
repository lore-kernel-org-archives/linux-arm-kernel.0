From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 06 May 2013 14:01:23 -0400
Subject: [RFC PATCH 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
Message-ID: <5187EFF3.6010005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/03/2013 01:35 PM, Will Deacon wrote:
> Hi all,
> 
> This small patch set may look a little over a month late, but there is a
> serious reason for posting it.
> 
> When I moved the ARM delay loop over to using the architected timers
> rather than the CPU spinning loop (which has all the problems associated
> with cpu frequency scaling and what-not) I thought I was doing something
> useful for the port. However, it turns out that a surprising number of
> people have complained, and continue to complain, about the drop in
> their `BogoMIPs score'.

Have you considered adding the old code back in, but in a form that's not at
all referenced by the delay loop code and just calculates CPU-based bogomips?

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
