From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 20 Jul 2015 22:44:08 +0200 (CEST)
Subject: [PATCH RESEND] irqchip: omap-intc: improve IRQ handler
In-Reply-To: <1437410759-4945-1-git-send-email-balbi@ti.com>
References: <1437410759-4945-1-git-send-email-balbi@ti.com>
Message-ID: <alpine.DEB.2.11.1507202241550.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jul 2015, Felipe Balbi wrote:
> +	irqnr = intc_readl(INTC_SIR);
> +	irqnr &= ACTIVEIRQ_MASK;
> +	WARN(!irqnr, "Spurious IRQ ?\n");

Shouldn't that be WARN_ONCE?

Thanks,

	tglx
