From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Fri, 14 Feb 2014 14:33:18 +0000
Subject: [PATCH RESEND] ARM: mcpm: Make all mcpm functions notrace
In-Reply-To: <1392279975.3469.4.camel@linaro1.home>
References: <1392279975.3469.4.camel@linaro1.home>
Message-ID: <52FE292E.70008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tixy,

On 13/02/14 08:26, Jon Medhurst (Tixy) wrote:
> From: Dave Martin <dave.martin@linaro.org>
> 
> The functions in mcpm_entry.c are mostly intended for use during
> scary cache and coherency disabling sequences, or do other things
> which confuse trace ...  like powering a CPU down and not
> returning.  Similarly for the backend code.
> 
> For simplicity, this patch just makes whole files notrace.
> There should be more than enough traceable points on the paths to
> these functions, but we can be more fine-grained later if there is
> a need for it.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Also added spc.o to the list of files as it contains functions used by
> MCPM code which have comments comments like: "might be used in code
> paths where normal cacheable locks are not working"
>

Just realised that spc.c now has OPP functionality too. As the comment above
says this can be fine grained later, but just wanted to mention here. IMO we can
restrict notrace to just below functions in spc.c

ve_spc_cpu_in_wfi
ve_spc_cpu_wakeup_irq
ve_spc_global_wakeup_irq
ve_spc_powerdown
ve_spc_set_resume_addr

Regards,
Sudeep
