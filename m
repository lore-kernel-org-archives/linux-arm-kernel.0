From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Mar 2013 10:33:55 -0700
Subject: [PATCH] irqchip: gic: fix irq_trigger return
In-Reply-To: <1363734349-32635-1-git-send-email-sboyd@codeaurora.org>
References: <1363734349-32635-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5151DC03.6070108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/13 16:05, Stephen Boyd wrote:
> From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
>
> The genirq layer expects a 0 in case of failure but the code is
> returning -ENXIO. Fix it.
>
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 644d724..2ebf28a 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -236,7 +236,8 @@ static int gic_retrigger(struct irq_data *d)
>  	if (gic_arch_extn.irq_retrigger)
>  		return gic_arch_extn.irq_retrigger(d);
>  
> -	return -ENXIO;
> +	/* the genirq layer expects 0 for a failure */
> +	return 0;
>  }
>  
>  #ifdef CONFIG_SMP

Ping.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
