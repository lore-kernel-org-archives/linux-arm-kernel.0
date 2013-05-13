From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 13 May 2013 11:14:06 -0400
Subject: [RFC PATCH 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <20130508090644.GA15692@mudshark.cambridge.arm.com>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <5187EFF3.6010005@codeaurora.org>
 <20130507090849.GC25387@mudshark.cambridge.arm.com>
 <5189224A.70501@codeaurora.org>
 <20130508090644.GA15692@mudshark.cambridge.arm.com>
Message-ID: <5191033E.2000303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/08/2013 05:06 AM, Will Deacon wrote:
> Hello Christopher,
> 
> On Tue, May 07, 2013 at 04:48:26PM +0100, Christopher Covington wrote:
>> On 05/07/2013 05:08 AM, Will Deacon wrote:
>>> That seems like a lot of effort in order to preserve something that isn't
>>> even meaningful. We might be better just zeroing the value, but then we'll
>>> inevitably get bug reports of it being `wrong'.
>>
>> If I were in to filing bug reports about bogomips values, I would be just as
>> likely to do it for 1, 10000, 99999, and get_random_bytes(...) as for 0.
> 
> That's a fair point, and one of the reasons I posted this as an RFC. I'd
> basically like an `obviously bogus' value so that people don't think `hey,
> my CPU sure it slow' and instead think `looks like this really is a bogus
> value after all'.
> 
> However, you're probably right that there isn't a number which can convey
> that information properly, so how about we just put a string in there along
> the lines of "not reported" and leave it at that?

That sounds reasonable to me.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
