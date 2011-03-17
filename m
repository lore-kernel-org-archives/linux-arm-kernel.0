From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 17 Mar 2011 23:33:25 +0100
Subject: [PATCH 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <083DF309106F364B939360100EC290F80B15AC2B40@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void __init lpc2478oem_init_irq(void)
> +{
> +	/* XXX workaround for the fact that EINT3 is connected to high-
> active
> +	 * signal, but can't be disabled. As the EINT3 interrupt is also
> used
> +	 * for GPIO interrupts, this will cause an interrupt storm without
> +	 * this setting.
> +	 */
> +	iowrite32(ioread32(APB_SCB_BASE + EXTPOLAR) | (1 << 3),
> +		APB_SCB_BASE + EXTPOLAR);
> +
> +	lpc2k_init_irq();
> +	lpc2k_init_clocks(12000000UL, 32768000UL);

Should the RTC clock be 32768?

> +}
> +
> +MACHINE_START(LPC2478OEM, "Embedded Artists LPC2478 OEM Board")
> +	.init_irq	= lpc2478oem_init_irq,
> +	.timer		= &lpc2k_timer,
> +	.init_machine	= lpc2478oem_init_machine,
> +MACHINE_END
