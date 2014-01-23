From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 16:19:19 +0000
Subject: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC
 related for ARM64
In-Reply-To: <52DCEA66.90903@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org>
 <52D93D4E.5020605@arm.com> <52DCEA66.90903@linaro.org>
Message-ID: <20140123161918.GA25927@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:20:38AM +0000, Hanjun Guo wrote:
> On 2014-1-17 22:25, Sudeep Holla wrote:
> > On 17/01/14 12:24, Hanjun Guo wrote:
> >> --- a/arch/arm64/kernel/process.c
> >> +++ b/arch/arm64/kernel/process.c
> >> @@ -89,6 +89,9 @@ void arch_cpu_idle_prepare(void)
> >>  	local_fiq_enable();
> >>  }
> >>  
> >> +unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
> >> +EXPORT_SYMBOL(boot_option_idle_override);
> >> +
> > 
> > This is what I mentioned in other email. Do we really foresee use of this in
> > ARM64 or it's just added to avoid build issues ?
> 
> Just avoid build issues, can not foresee use of this in ARM64 :)

So ideally we should look for a better solution here.

-- 
Catalin
