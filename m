From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Oct 2018 11:50:43 -0700
Subject: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
In-Reply-To: <87tvl9nas6.fsf@xmission.com>
References: <20181025180957.7900-1-f.fainelli@gmail.com>
 <87tvl9nas6.fsf@xmission.com>
Message-ID: <a48601e2-dde2-47b8-b591-ffccdc9f1bf8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/18 11:25 AM, Eric W. Biederman wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
>> Some software such as perf makes unconditional use of the special
>> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
>> enabled in the kernel.
>>
>> Facilitate the debugging of such situations by printing a debug message
>> to the kernel log showing the task name and the faulting address.
> 
> Can't someone trigger this segv deliberately and spam the kerne log?
> Doesn't this need something like printk_ratelimit or something to ensure
> this message only gets printed once?

Yes, good point, thanks.
-- 
Florian
