From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 09:11:24 +0000
Subject: SMP local timers and their CPUfreq notifiers setup on OMAP3
In-Reply-To: <4F3E47F2.2090400@ti.com>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com>
 <0401fed02a58f7bc48cc274050adbac7@localhost>
 <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
 <4F3E34A3.4000307@arm.com> <4F3E47F2.2090400@ti.com>
Message-ID: <20120221091124.GB22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 05:58:34PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..9834851 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
> 
>  static int twd_cpufreq_init(void)
>  {
> -	if (!IS_ERR(twd_clk))
> +	 if (twd_evt && *__this_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))

You seem to have an additional space before 'if'.
