From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 14 Oct 2011 11:57:54 +0200
Subject: Warning in -next w/ "ARM: 7011/1: Add ARM cpu topology definition"
In-Reply-To: <20111014093100.GA23994@mudshark.cambridge.arm.com>
References: <20111014093100.GA23994@mudshark.cambridge.arm.com>
Message-ID: <CAKfTPtBMrDi3bVjdxLTJX729_6jHtsbqXHV6BRWcnpZ_D5Duvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for pointing out this.

I have based my cpu topology patch on sh one which also uses unsigned
int and haven't noticed this warning during compilation

I'm going to fix this

Vincent

On 14 October 2011 11:31, Will Deacon <will.deacon@arm.com> wrote:
> Hi Vincent,
>
> When compiling next with SCHED_MC enabled I get a warning from sched.c
> because your topology functions (declared in arch/arm/include/asm/topology.h)
> take unsigned int cpu rather than int cpu:
>
> kernel/sched.c:7354:2: warning: initialization from incompatible pointer type
>
> 7353 #ifdef CONFIG_SCHED_MC
> 7354 ? ? ? ? { sd_init_MC, cpu_coregroup_mask, },
> 7355 #endif
>
> Apologies if you've already got a fix queued for this,
>
> Will
>
