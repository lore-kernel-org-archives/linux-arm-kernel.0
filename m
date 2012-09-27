From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 27 Sep 2012 11:35:22 +0200
Subject: [PATCH V5 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
Message-ID: <1348738523-28609-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 07:11 PM, Catalin Marinas wrote:> On 26 September 2012 17:02, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> +static void aurora_pa_range(unsigned long start, unsigned long end,
>> +                       unsigned long offset)
>> +{
>> +       unsigned long flags;
>> +
>> +       raw_spin_lock_irqsave(&l2x0_lock, flags);
>> +       writel(start, l2x0_base + AURORA_RANGE_BASE_ADDR_REG);
>> +       writel(end, l2x0_base + offset);
> 
> Just use writel_relaxed() here for consistency and possible deadlock avoidance.
> 

OK I fixed it in the git repo and I also send the updated patch.

Russell do you agree to take the series now?

Thanks.
