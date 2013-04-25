From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 25 Apr 2013 14:50:18 +0100
Subject: [PATCH] ARM: make cpu_init() notrace
In-Reply-To: <20130425121504.GD14496@n2100.arm.linux.org.uk>
References: <1366302046.3388.8.camel@linaro1.home>
 <20130422140711.GI14496@n2100.arm.linux.org.uk>
 <1366654116.3989.16.camel@computer5.home>
 <20130425121504.GD14496@n2100.arm.linux.org.uk>
Message-ID: <1366897818.3528.38.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 13:15 +0100, Russell King - ARM Linux wrote:

> $ pdb getpatch 7700/1 |tr ' ' '_' |less
> diff_--git_a/arch/arm/kernel/setup.c_b/arch/arm/kernel/setup.c
> index_d343a6c..943cbf0_100644
> ---_a/arch/arm/kernel/setup.c
> +++_b/arch/arm/kernel/setup.c
> @@_-390,7_+390,7_@@_static_void___init_feat_v6_fixup(void)
> __*
> __*_cpu_init_sets_up_the_per-CPU_stacks.
> __*/
> -void_cpu_init(void)
> +void_notrace_cpu_init(void)
> _{
> ________unsigned_int_cpu_=_smp_processor_id();
> ________struct_stack_*stk_=_&stacks[cpu];
> 
> Can you guess why git has a problem appying the above... 

Sorry about that, the user forgot to tell their mailer it was
pre-formatted text. I've sent a fixed version.

Note to self: bcc self on patch submissions and then run them though
'git am' to catch problems before others hit them.

-- 
Tixy
