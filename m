From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Oct 2015 16:00:24 +0200
Subject: [PATCH 2/5] irqchip: armada-370-xp: prepare additions to
 armada_xp_mpic_secondary_init()
In-Reply-To: <1445347435-2333-3-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 20 Oct 2015 15:23:52 +0200")
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87io61ej2f.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., oct. 20 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> As a preparation to adding more code in
> armada_xp_mpic_secondary_init(), this commit slightly refactors the
> current function to bail out early if we're not handling the actions
> of interest.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  drivers/irqchip/irq-armada-370-xp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 655cb96..f5afe81 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -377,10 +377,11 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
>  static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
>  					 unsigned long action, void *hcpu)
>  {
> -	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN) {
> -		armada_xp_mpic_perf_init();
> -		armada_xp_mpic_smp_cpu_init();
> -	}
> +	if (action != CPU_STARTING && action != CPU_STARTING_FROZEN)
> +		return NOTIFY_OK;
> +
> +	armada_xp_mpic_perf_init();
> +	armada_xp_mpic_smp_cpu_init();
>  
>  	return NOTIFY_OK;
>  }
> -- 
> 2.6.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
