From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 21 Feb 2013 21:57:46 -0800
Subject: [RFC/PATCH 2/5] kernel_cpustat: convert to atomic 64-bit accessors
In-Reply-To: <CAFTL4hzHbp-JYgAbMRc4tefJZh9ZVdqGMp3ZTQAe-kmaX1fC3w@mail.gmail.com>
 (Frederic Weisbecker's message of "Thu, 21 Feb 2013 22:54:43 +0100")
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
 <1361389302-11968-3-git-send-email-khilman@linaro.org>
 <87y5ehmp8d.fsf@linaro.org>
 <CAFTL4hw1=mKtUadL0WDrydtspOehKuW7jhhzr65vXR2P2zdTWw@mail.gmail.com>
 <CAFTL4hzHbp-JYgAbMRc4tefJZh9ZVdqGMp3ZTQAe-kmaX1fC3w@mail.gmail.com>
Message-ID: <8738woriud.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> 2013/2/21 Frederic Weisbecker <fweisbec@gmail.com>:
>> 2013/2/21 Kevin Hilman <khilman@linaro.org>:
>>> Subject: [PATCH 2/5] kernel_cpustat: convert to atomic 64-bit accessors
>>>
>>> Use the atomic64_* accessors for all the kernel_cpustat fields to
>>> ensure atomic access on non-64 bit platforms.
>>>
>>> Thanks to Mats Liljegren for CGROUP_CPUACCT related fixes.
>>>
>>> Cc: Mats Liljegren <mats.liljegren@enea.com>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>
>> Funny stuff, I thought struct kernel_cpustat was made of cputime_t
>> field. Actually it's u64. So the issue is independant from the new
>> full dynticks cputime accounting. It was already broken before.
>>
>> But yeah that's not the point, we still want to fix this anyway. But
>> let's just treat this patch as independant.

OK, I just sent an updated series based on your proposal.

Thanks for the review,

Kevin
