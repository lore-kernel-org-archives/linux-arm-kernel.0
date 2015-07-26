From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 26 Jul 2015 11:52:52 +0200 (CEST)
Subject: [PATCH v2 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <1436837718-956-5-git-send-email-eric@anholt.net>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
 <1436837718-956-5-git-send-email-eric@anholt.net>
Message-ID: <alpine.DEB.2.11.1507261150500.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jul 2015, Eric Anholt wrote:
> +static void
> +bcm2836_arm_irqchip_smp_init(void)
> +{
> +#ifdef CONFIG_SMP
> +	int i;
> +
> +	/* unmask IPIs */
> +	for_each_possible_cpu(i) {
> +		bcm2836_arm_irqchip_unmask_per_cpu_irq(
> +			LOCAL_MAILBOX_INT_CONTROL0, 0, i);

Do you really want to enable these interrupts on all possible cpus? Why so?

Shouldn't that be done at the point where a hotplugged CPU is starting ?

Thanks,

	tglx
