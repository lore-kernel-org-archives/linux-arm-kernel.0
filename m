From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 10:45:43 +0100
Subject: [PATCH V5 2/5] ARM: bcm2835: add interrupt controller driver
In-Reply-To: <1347690093-16910-2-git-send-email-swarren@wwwdotorg.org>
References: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
 <1347690093-16910-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120915094543.GH12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 12:21:30AM -0600, Stephen Warren wrote:
> +static struct irq_chip armctrl_chip = {
> +	.name = "ARMCTRL-level",
> +	.irq_mask = armctrl_mask_irq,
> +	.irq_unmask = armctrl_unmask_irq
> +};

Might we want to enable CONFIG_GENERIC_IRQ_SHOW_LEVEL ?
