From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Sep 2012 18:11:49 +0100
Subject: [PATCH V5 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <1348675370-16359-4-git-send-email-gregory.clement@free-electrons.com>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
 <1348675370-16359-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 September 2012 17:02, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> +static void aurora_pa_range(unsigned long start, unsigned long end,
> +                       unsigned long offset)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&l2x0_lock, flags);
> +       writel(start, l2x0_base + AURORA_RANGE_BASE_ADDR_REG);
> +       writel(end, l2x0_base + offset);

Just use writel_relaxed() here for consistency and possible deadlock avoidance.

-- 
Catalin
