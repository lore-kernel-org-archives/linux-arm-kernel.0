From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 07 May 2013 11:48:26 -0400
Subject: [RFC PATCH 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <20130507090849.GC25387@mudshark.cambridge.arm.com>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <5187EFF3.6010005@codeaurora.org>
 <20130507090849.GC25387@mudshark.cambridge.arm.com>
Message-ID: <5189224A.70501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 05:08 AM, Will Deacon wrote:
> On Mon, May 06, 2013 at 07:01:23PM +0100, Christopher Covington wrote:
>> Hi Will,
>>
>> On 05/03/2013 01:35 PM, Will Deacon wrote:
>>> Hi all,
>>>
>>> This small patch set may look a little over a month late, but there is a
>>> serious reason for posting it.
>>>
>>> When I moved the ARM delay loop over to using the architected timers
>>> rather than the CPU spinning loop (which has all the problems associated
>>> with cpu frequency scaling and what-not) I thought I was doing something
>>> useful for the port. However, it turns out that a surprising number of
>>> people have complained, and continue to complain, about the drop in
>>> their `BogoMIPs score'.
>>
>> Have you considered adding the old code back in, but in a form that's not at
>> all referenced by the delay loop code and just calculates CPU-based bogomips?
> 
> That seems like a lot of effort in order to preserve something that isn't
> even meaningful. We might be better just zeroing the value, but then we'll
> inevitably get bug reports of it being `wrong'.

If I were in to filing bug reports about bogomips values, I would be just as
likely to do it for 1, 10000, 99999, and get_random_bytes(...) as for 0.

> Plus, the calibration during boot introduces a brief delay when onlining
> each core whereas this can be skipped when using a constant timer.

If it were configurable, that might give people a reason to weigh whether they
really cared about knowing bogomips at the cost of boot time.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
